<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Models\User;
use Illuminate\Http\Request;
use function PHPSTORM_META\map;

class NotificationController extends Controller
{
    public function index(Request $request): \Illuminate\Http\JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'notifications' => $user->notifications()->latest()->get()
        ]);
    }

    /**
     * Get unread notifications
     */
    public function unread(Request $request): \Illuminate\Http\JsonResponse
    {
        $user = $request->user();

        return response()->json([
            'notifications' => $user->notifications()->where('is_read', false)->latest()->get()
        ]);
    }

    /**
     * Mark a notification as read
     */
    public function markAsRead(Request $request,$id): \Illuminate\Http\JsonResponse
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', $request->user()->id)
            ->first();
        if (!$notification) {
            return response()->json(['message' => 'Notification not found.'], 404);
        }
        $notification->update(['is_read' => true]);

        return response()->json(['message' => 'Notification marked as read.']);
    }

    /**
     * Create notification for seeker when application is accepted/rejected
     */
    public function notifySeekerApplicationStatus($seekerId, $status): \Illuminate\Http\JsonResponse
    {
        $message = $status === 'accepted'
            ? 'Your application has been accepted. Please contact the company for an interview.'
            : 'Your application has been rejected. Better luck next time.';

        Notification::create([
            'user_id' => $seekerId,
            'message' => $message,
            'type' => 'application_status',
            'is_read' => false
        ]);

        return response()->json(['message' => 'Notification sent to seeker.']);
    }

    /**
     * Create notification for employer when seeker applies or favorites a job
     */
    public function notifyEmployerActivity($employerId, $type): \Illuminate\Http\JsonResponse
    {
        $message = '';

        if ($type === 'applied') {
            $message = 'A seeker has applied to one of your job postings.';
        } elseif ($type === 'favorited') {
            $message = 'A seeker has added your job to their favorites.';
        }

        Notification::create([
            'user_id' => $employerId,
            'message' => $message,
            'type' => 'seeker_activity',
            'is_read' => false
        ]);

        return response()->json(['message' => 'Notification sent to employer.']);
    }


    /**
     * Return all user notifications with redirect_url
     */

    public function getUserNotifications(Request $request): \Illuminate\Http\JsonResponse
    {
        $notifications = Notification::with('user')
        -> where('user_id', auth()->id())
            ->orderBy('created_at', 'desc')
            ->get()
        ->map(function ($notification) {
            return array_merge($notification->toArray(), [
                'redirect_url' => $this->generatedRedirectUrl($notification)
            ]);
    });


        return response()->json($notifications);
    }

    private function generatedRedirectUrl( Notification $notification): string

    {
        switch ($notification->type) {
            case 'application_status':
                return '/seeker/applications-status';

                case 'seeker_activity':
                    return '/employer/job-applications';

                    default:
                        return '/';

        }
    }
}
