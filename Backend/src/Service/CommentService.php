<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\CommentEntity;
use App\Manager\CommentManager;
use App\Request\SwapItemCommentCreateRequest;
use App\Response\SwapItemCommentCreateResponse;
use App\Response\SwapItemCommentResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CommentService
{
    private $autoMapping;
    private $commentManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, CommentManager $commentManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->commentManager = $commentManager;
        $this->params = $params->get('upload_base_url').'/';
    }

    public function createSwapItemComment(SwapItemCommentCreateRequest $request)
    {
        $commentCreate = $this->commentManager->commentCreate($request);

        $response = $this->autoMapping->map(CommentEntity::class,SwapItemCommentCreateResponse::class, $commentCreate);

        return $response;
    }

    public function getCommentsByID($id)
    {
        $commentsResponse= [];
        $comments = $this->commentManager->getCommentsByID($id);

        foreach ($comments as $comment)
        {
            $comment['image'] =  $this->params.$comment['image'];
            $commentsResponse[] = $this->autoMapping->map('array', SwapItemCommentResponse::class, $comment);
        }

        return $commentsResponse;
    }

    public function commentsNumber($id)
    {
        return $this->commentManager->commentsNumber($id)[1];
    }

    public function getCommentsByUserID($userID)
    {
        $commentsResponse= [];
        $comments = $this->commentManager->getCommentsByUserID($userID);

        foreach ($comments as $comment)
        {
            $commentsResponse[] = $this->autoMapping->map('array', SwapItemCommentResponse::class, $comment);
        }

        return $commentsResponse;
    }

    public function commentsNumberByUserID($userID)
    {
        return $this->commentManager->commentsNumberByUserID($userID)[1];
    }
}