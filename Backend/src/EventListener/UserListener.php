<?php


namespace App\EventListener;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\ControllerArgumentsEvent;
use Symfony\Component\HttpKernel\Event\ControllerEvent;
use Symfony\Component\HttpKernel\Event\FinishRequestEvent;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\Security\Http\Event\InteractiveLoginEvent;

class UserListener implements EventSubscriberInterface
{
    protected $user;

    static function getSubscribedEvents()
    {
        return [
            InteractiveLoginEvent::class =>  ['onSecurityInteractiveLogin'],
            KernelEvents::REQUEST => ['onKernelRequest']
        ];
    }

    public function onSecurityInteractiveLogin(InteractiveLoginEvent $event)
    {
        $this->setUser($event->getAuthenticationToken()->getUser()->getUsername());
    }

    public function onKernelRequest(RequestEvent $event)
    {
       $event->getRequest()->request->set('userID', $this->getUser());
    }

    /**
     * @return mixed
     */
    public function getUser()
    {
        return $this->user;
    }

    /**
     * @param mixed $user
     */
    public function setUser($user): void
    {
        $this->user = $user;
    }

}