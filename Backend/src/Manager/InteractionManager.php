<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Interaction;
use App\Repository\InteractionRepository;
use App\Request\CreateInteractionRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\UpdateInteractionRequest;

class InteractionManager
{
    private $entityManager;
    private $interactionRepository;
    private $autoMapping;   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    InteractionRepository $interactionRepository, AutoMapping $autoMapping )
    {
        $this->entityManager          = $entityManagerInterface;
        $this->interactionRepository  = $interactionRepository;
        $this->autoMapping            = $autoMapping;
    }

    public function create(CreateInteractionRequest $request)
    {
        $interActionEntity = $this->autoMapping->map(CreateInteractionRequest::class, Interaction::class, $request);
        $interActionEntity->setDate($request->getDate());

        $this->entityManager->persist($interActionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $interActionEntity;
    }

    public function update(UpdateInteractionRequest $request)
    {
        $interaction = $this->interactionRepository->find($request->getId());
        $interaction->setDate($request->getDate());

        if (!$interaction)
        {

        }
        else
        {
            $interaction = $this->autoMapping->mapToObject(UpdateInteractionRequest::class, Interaction::class, $request, $interaction);
            $this->entityManager->flush();
        }
        return $interaction;
    }

    public function getAll($swapItemID)
    {
        return $this->interactionRepository->getAll($swapItemID);
    }

    public function getInteractionWithUser($swapItemID, $userID)
    {
        return $this->interactionRepository->getInteractionWithUser($swapItemID, $userID);
    }

    public function countInteractions($swapItemID)
    {
        return $this->interactionRepository->countInteractions($swapItemID);
    }

    public function getLove($swapItemID)
    {
        return $this->interactionRepository->getAllLove($swapItemID);
    }

    public function checkUserLoved($swapItemID, $userID)
    {
        $loved = $this->interactionRepository->checkUserLoved($swapItemID, $userID);

        if ($loved[1] > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}