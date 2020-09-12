<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\SwapItemCommentCreateRequest;
use App\Service\CommentService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class CommentController extends BaseController
{
    private $autoMapping;
    private $commentService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, CommentService $commentsService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->commentService = $commentsService;
        $this->validator = $validator;
    }

    /**
     * @Route("/comment", name="createSwapItemComment", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function createSwapItemComment(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,SwapItemCommentCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->commentService->createSwapItemComment($request);

        return $this->response($response, self::CREATE);
    }
}
