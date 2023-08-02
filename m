Return-Path: <Samuel.J.Hasenbosch@boeing.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1A9681455
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAAFD81427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
 s=boeing-s1912; t=1690947946;
 bh=/nHf9NxBGW23Fp6Y5PeD4ZkfKtKauHk4FoBOYk3h8rM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=OceHmJNGGNNunLZ/MsHfuVo9kFdJ6p9BGtp2TqlcyvqvRcmSjG5OMp+yALCpCqdsX
 dQK2mllU1X7r4DgznLUgc1nCwfSQX4wOMHfZIqcLomalz/2nXdR7ywKJzc2jiqG+BH
 lpHYdIwuY8WDv07WwYF/pN+iqeTsFH3nsgGsy2Zl2P5fn+HAhaa2gFxN8DaoxOi8TC
 8UA52HbGnRiDwKdqKotqaeNqNcmzwdqqVJKuedaEY8hVuuCjgDL9/dddryxMff4d0/
 xbCv8dgA6F58qgDKIgUG3rq8aB5v70XQmjWuBopqC0Es2b8mxHit0bSQkqW6ho95+c
 qHGXsIlkGfVdQ==
From: "Hasenbosch, Samuel J" <Samuel.J.Hasenbosch@boeing.com>
Date: Wed, 2 Aug 2023 03:45:40 +0000
Message-ID: <0acf2133dc8f47d3ac40e718ab014b59@boeing.com>
References: <b1b77fe134e64bfc85394050bd40dff6@boeing.com>
In-Reply-To: <b1b77fe134e64bfc85394050bd40dff6@boeing.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [bridge]: STP: no port in blocking state despite a
 loop when in a network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bugs.a.b@free.fr" <bugs.a.b@free.fr>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>


Forwarding related issue:

https://lore.kernel.org/netdev/20230711174934.3871fb61@kernel.org/T/#m4d530=
64313393cdee86f12ef9313523aa734d681
