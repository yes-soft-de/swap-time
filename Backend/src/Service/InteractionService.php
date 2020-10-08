<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Interaction;
use App\Manager\InteractionManager;
use App\Response\CountInteractionResponse;
use App\Response\CreateInteractionResponse;
use App\Response\InteractionResponse;
use App\Response\UpdateInteractionResponse;
use App\Response\GetInteractionResponse;

class InteractionService
{
    private $interactionManager;
    private $autoMapping;

    public function __construct(InteractionManager $interactionManager, AutoMapping $autoMapping)
    {
        $this->interactionManager = $interactionManager;
        $this->autoMapping        = $autoMapping;
    }
  
    public function create($request)
    {
        $interactionManager = $this->interactionManager->create($request);

        return $this->autoMapping->map(Interaction::class, CreateInteractionResponse::class, $interactionManager);
    }

    public function update($request)
    {
        $interactionResult = $this->interactionManager->update($request);
     
        $response = $this->autoMapping->map(Interaction::class, UpdateInteractionResponse::class, $interactionResult);
        
        return $response;   
    }
    
    public function getAll($animeID)
    {
        $result = $this->interactionManager->getAll($animeID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Interaction::class, GetInteractionResponse::class, $row);
        }

        return $response;
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        $result = $this->interactionManager->getInteractionWithUser($animeID, $userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Interaction::class, GetInteractionResponse::class, $row);
        }

        return $response;
    }

    public function countInteractions($animeId)
    {
        $result = $this->interactionManager->countInteractions($animeId);

        $response =  $this->autoMapping->map('array', CountInteractionResponse::class, $result);
        $response->setCountInteraction($result);
        return $response;
    }

    public function getLove($swapItemID)
    {
        return $this->interactionManager->getLove($swapItemID)[1];
    }

    public function checkUserLoved($swapItemID, $userID)
    {
        return $this->interactionManager->checkUserLoved($swapItemID, $userID);
    }
}