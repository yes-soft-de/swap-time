<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\NotificationTokenEntity;
use App\Manager\NotificationManager;
use App\Request\NotificationTokenRequest;
use App\Response\NotificationTokenResponse;
use Kreait\Firebase\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class NotificationService
{
    private $messaging;
    private $notificationManager;
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationManager $notificationManager)
    {
        $this->messaging = $messaging;
        $this->notificationManager = $notificationManager;
        $this->autoMapping = $autoMapping;
    }

    public function sendMessage()
    {
        $deviceToken = 'dwooFCbVSmOYJRbEWB9Yho:APA91bGNejY5N9Wj5oYj4MmkqwCuAfEBBzlYcPjKaWkF8axZmFhjAJ3yo6cJE2vJg9iMek5-F0mLOTz9HG5FYMdtJkgNTFpTwiRsYz786WlxcceegY3OFtUJ-cpLHbw3dYcqGNpO-P9A';

        $message = CloudMessage::withTarget('token', $deviceToken)
            ->withNotification(Notification::create('Hi', 'U got message yay!'))
            ->withData(['key' => 'value']);

        $this->messaging->send($message);
    }

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $userRegister = $this->notificationManager->notificationTokenCreate($request);

        return $this->autoMapping->map(NotificationTokenEntity::class,NotificationTokenResponse::class, $userRegister);
    }
}