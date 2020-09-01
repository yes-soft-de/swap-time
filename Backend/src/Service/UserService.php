<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\UserRegisterResponse;

class UserService
{
    private $autoMapping;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        $response = $this->autoMapping->map(UserEntity::class,UserRegisterResponse::class, $userRegister);

        return $response;
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->userManager->userProfileCreate($request);

        $response = $this->autoMapping->map(UserProfileEntity::class,UserProfileCreateResponse::class, $userProfile);

        return $response;
    }
}