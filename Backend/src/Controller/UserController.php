<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Service\NotificationService;
use App\Service\UserService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class UserController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $userService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->userService = $userService;
    }

    /**
     * @Route("/user", name="userRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserRegisterRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="userProfileCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userProfileCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserProfileCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userProfileCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="updateUserProfile", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateUserProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserProfileUpdateRequest::class,(object)$data);

        $response = $this->userService->userProfileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/userprofile/{id}", name="getUserProfileByID",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getUserProfileByID(Request $request)
    {
        $response = $this->userService->getUserProfileByUserID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("userprofileall", name="getAllUsersProfiles", methods={"GET"})
     * @return JsonResponse
     */
    public function userProfileAll()
    {
        $response = $this->userService->getAllProfiles();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("ok", name="ok", methods={"POST"})
     * @return JsonResponse
     */
    public function ok(NotificationService $notificationService)
    {
        $notificationService->sendMessage();

        return $this->response('ok',self::FETCH);
    }
}
