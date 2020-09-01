<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\SwapItemCreateRequest;
use App\Service\SwapItemService;
use stdClass;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class SwapItemController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $swapItemService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, SwapItemService $swapItemService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->swapItemService = $swapItemService;
    }

    /**
     * @Route("/swapitem", name="swapItemCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function swapItemCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,SwapItemCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->swapItemService->swapItemCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/swapitem", name="swapItems", methods={"GET"})
     * @return JsonResponse
     */
    public function getSwapItems()
    {
        $response = $this->swapItemService->getSwapItems();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/swapitembyid/{id}", name="swapItemById", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function swapItemById(Request $request)
    {
        $response = $this->swapItemService->getSwapItemByID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/swapitembyuserid/{id}", name="swapItemByUserId", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function swapItemByUserId(Request $request)
    {
        $response = $this->swapItemService->getSwapItemByUserID($request->get('id'));

        return $this->response($response,self::FETCH);
    }
}
