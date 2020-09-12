<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\CommentEntity;
use App\Repository\CommentEntityRepository;
use App\Request\SwapItemCommentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CommentManager
{
    private $autoMapping;
    private $entityManager;
    private $commentEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CommentEntityRepository $commentEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->commentEntityRepository = $commentEntityRepository;
    }

    public function commentCreate(SwapItemCommentCreateRequest $request)
    {
        $commentCreate = $this->autoMapping->map(SwapItemCommentCreateRequest::class, CommentEntity::class, $request);

        $commentCreate->setDate($request->getDate());

        $this->entityManager->persist($commentCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $commentCreate;
    }

    public function getCommentsByID($id)
    {
        return $this->commentEntityRepository->getCommentsByID($id);
    }

    public function commentsNumber($id)
    {
        return $this->commentEntityRepository->commentsNumber($id);
    }

    public function getCommentsByUserID($userID)
    {
        return $this->commentEntityRepository->getCommentsByUserID($userID);
    }

    public function commentsNumberByUserID($userID)
    {
        return $this->commentEntityRepository->commentsNumberByUserID($userID);
    }
}