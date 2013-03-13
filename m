Return-Path: <sysoleg@yandex.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1363155744; bh=ORsVrqr9v23NqK3U23INZzvLCTscthqq0Gwgn5psW90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C2LiOm9gqw8eIN0gUPIbz1m61LKzIsXQO143h/2v+SSxuMWVTChB+IFVB67pj7kKS
	9CYk4bVl3s6s5uLURmTRjdvBiEpHpmGck6Z110hs67IeoLA0WEfCmGgOGtCgDHlfXW
	RDqk6cXltiwdr3Dc5Ni25QS8tUdRSkwtdBIpcmcs=
From: "\"Oleg A. Arkhangelsky\"" <sysoleg@yandex.ru>
In-Reply-To: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
References: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
MIME-Version: 1.0
Message-Id: <473541363155743@web2d.yandex.ru>
Date: Wed, 13 Mar 2013 10:22:23 +0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 0/4] Allow bridge to function in
	non-promisc mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>



13.03.2013, 05:45, "Vlad Yasevich" <vyasevic@redhat.com>:

> The series adds an ability for the bridge to function in non-promiscuous mode.

What is the practical applications for such setup? In other words,
in which cases I would want to put bridge into non-promiscuous
mode and specify some uplink ports?

-- 
wbr, Oleg.

"Anarchy is about taking complete responsibility for yourself."
 Alan Moore.
