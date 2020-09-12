<?php

namespace App\Repository;

use App\Entity\CommentEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CommentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommentEntity[]    findAll()
 * @method CommentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CommentEntity::class);
    }

    public function getCommentsByID($id)
    {
        $r = $this->createQueryBuilder('comments')
            ->select('comments.id', 'comments.comment', 'comments.date', 'comments.userID', 'comments.swapItemID')

            ->andWhere('comments.swapItemID=:id')
            ->setParameter('id',$id)

            ->getQuery()
            ->getArrayResult();

        return $r;
    }

    public function commentsNumber($id)
    {
        return $this->createQueryBuilder('commentNumber')
            ->select('count(commentNumber)')
            ->andWhere('commentNumber.swapItemID = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCommentsByUserID($userID)
    {
        $r = $this->createQueryBuilder('comments')
            ->select('comments.id', 'comments.comment', 'comments.date', 'comments.userID', 'comments.swapItemID')

            ->andWhere('comments.userID=:id')
            ->setParameter('id',$userID)

            ->getQuery()
            ->getArrayResult();

        return $r;
    }

    public function commentsNumberByUserID($userID)
    {
        return $this->createQueryBuilder('commentNumber')
            ->select('count(commentNumber)')
            ->andWhere('commentNumber.userID = :id')
            ->setParameter('id', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
