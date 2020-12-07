<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\InteractionService;
use App\Request\CreateInteractionRequest;
use Symfony\Component\HttpFoundation\Response;
use App\Request\UpdateInteractionRequest;
use Symfony\Component\Serializer\SerializerInterface;

class InteractionController extends BaseController
{
    private $interactionService;
    private $autoMapping;

    public function __construct(SerializerInterface $serializer, InteractionService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/interaction", name="createInteraction",methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
         $data = json_decode($request->getContent(), true);

         $request = $this->autoMapping->map(\stdClass::class,CreateInteractionRequest::class, (object)$data);

         $result = $this->interactionService->create($request);

         return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/interaction/{userID}/{animeID}/{type}", name="updateInteraction", methods={"PUT"})
     * @param Request $request
     * @param $userID
     * @param $animeID
     * @param $type
     * @return JsonResponse|Response
     */
    public function update(Request $request, $userID, $animeID, $type)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionRequest::class, (object) $data);
        $request->setUserID($userID);
        $request->setAnimeID($animeID);
        $request->setType($type);
        $result = $this->interactionService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/interaction/{animeID}", name="getAllInteractionWithAllUsersByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAll($animeID)
    {
        $result = $this->interactionService->getAll($animeID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interaction/{animeID}/{userID}", name="getAllInterActionWithUserByAnimeIDAndUserID", methods={"GET"})
     * @param $animeID
     * @param $userID
     * @return JsonResponse
     */
    public function getInteractionWithUser($animeID, $userID)
    {
        $result = $this->interactionService->getInteractionWithUser($animeID, $userID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/countInteractions/{animeID}", name="countInteractionsByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function countInteractions($animeID)
    {
        $result = $this->interactionService->countInteractions($animeID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/userinteraction", name="getUserInteractions1", methods={"GET"})
     * @return JsonResponse
     */
    public function UserInteractions()
    {
        $userID = 0;
        if ($this->getUser())
        {
            $userID = $this->getUser()->getUsername();
        }

        $result = $this->interactionService->getUserInteraction($userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interaction/{itemID}", name="deleteInteraction", methods={"DELETE"})
     * @param $itemID
     * @return JsonResponse
     */
    public function deleteInteraction($itemID)
    {
        $userID = 0;
        if ($this->getUser())
        {
            $userID = $this->getUser()->getUsername();
        }

        $result = $this->interactionService->deleteInteraction($itemID);

        return $this->response($result, self::DELETE);
    }
}
