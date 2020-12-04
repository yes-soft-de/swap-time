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
use App\Response\UserInteractionsResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class InteractionService
{
    private $interactionManager;
    private $autoMapping;
    private $params;

    public function __construct(InteractionManager $interactionManager, AutoMapping $autoMapping, ParameterBagInterface $params)
    {
        $this->interactionManager = $interactionManager;
        $this->autoMapping        = $autoMapping;
        $this->params = $params->get('upload_base_url').'/';
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

    public function getUserInteraction($userID)
    {
        $result = $this->interactionManager->getUserInteraction($userID);

        $response = [];

        foreach ($result as $row) {
            $row['mainImage'] =  $this->specialLinkCheck($row['specialLink']).$row['mainImage'];

            $response[] = $this->autoMapping->map('array', UserInteractionsResponse::class, $row);

        }

        return $response;
    }

    public function specialLinkCheck($bool)
    {
        if ($bool == false)
        {
            return $this->params;
        }
    }
}