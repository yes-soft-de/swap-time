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

    public function sendMessage($request)
    {
        $devicesToken = [];
        $userTokenOne = $this->getNotificationTokenByUserID($request->getUserIdOne());
        $devicesToken[] = $userTokenOne;
        $userTokenTwo = $this->getNotificationTokenByUserID($request->getUserIdTwo());
        $devicesToken[] = $userTokenTwo;

        $message = CloudMessage::new()
            ->withNotification(Notification::create('Swap Time', $request->getMessage()));


//        $message = CloudMessage::withTarget('token', $deviceToken)
//            ->withNotification(Notification::create('Hi', 'U got message yay!'))
//            ->withData(['key' => 'value']);

        $this->messaging->sendMulticast($message, $devicesToken);
    }

    public function notificationTokenCreate(NotificationTokenRequest $request)
    {
        $userRegister = $this->notificationManager->notificationTokenCreate($request);

        return $this->autoMapping->map(NotificationTokenEntity::class,NotificationTokenResponse::class, $userRegister);
    }

    public function getNotificationTokenByUserID($userID)
    {
        return $this->notificationManager->getNotificationTokenByUserID($userID);
    }


}