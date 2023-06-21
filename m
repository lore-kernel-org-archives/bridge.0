Return-Path: <astrajoan@yahoo.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22B5A60E64
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A54D160C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1687331837; bh=+8YeTsFFP4/LcuYhuxZ+DHkGB6oZ92zKrQG3Mx2GKvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=UgzbR1lwHoVb127rQHtmF22wYxJ6Em+1l8crY6Nv8qhedtvzudXXRRuKQ3jlVPkPQZhFD/yF+cftnXygxEWHdER5c3KcfJDL8GrKlIkigOKnlf1jM11MJ3L0NLmZd3ncxs4yInFEVTt2BySt+POfgdKKlbWFUmRsV0MPaE3Idt9Cz/uXOYKa4vqkfpNtUz13MF+3/1P+W4c0EqEhUkA3MNLC6hviSRfpF4wqH6Cb2D69Zmo+2gzIpZ7ENTQ2+HmZvIgik3d+nI9ScWUfOOKoF2DA++FtzN+6nyTzWbHyf++a03tTUEMRaWiRL+LhtBFpBRqUj9aoaKMX2/Yi18X54w==
From: Ziqi Zhao <astrajoan@yahoo.com>
Date: Wed, 21 Jun 2023 07:07:10 +0000
Message-Id: <20230621070710.380373-1-astrajoan@yahoo.com>
In-Reply-To: <00000000000051197705fdbc7e54@google.com>
References: <00000000000051197705fdbc7e54@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [syzbot] [net?] unregister_netdevice: waiting for DEV
	to become free (8)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Cc: ivan.orlov0322@gmail.com, arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, edumazet@google.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, skhan@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net

Hi all,

I'm taking a look at this bug as part of the exercice for the Linux
Kernel Bug Fixing Summer 2023 program. Thanks to the help from my
mentor, Ivan Orlov and Shuah Khan, I've already obtained a reproduction
of the issue using the provided C reproducer, and I should be able to
submit a patch by the end of this week to fix the highlighted error. If
you have any information or suggestions, please feel free to reply to
this thread. Any help would be greatly appreciated!

Best regards,
Ziqi
