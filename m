Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=naAJVPlGmGjLeTXnlA2J2f7npcKQ7miJ51HFyvZQdOU=;
	b=Go6ZotZx5vSfPrpR00Jn8VhU6LVCPl+kyrZTU8mALT8c+4OPFE5V3B7wjTwKi87CRi
	NVXH5hn+Kq6I5dYSyFzSehD//IQ8ImSmguHhyceGJGvzoyr5MRleF2L3OuE2Y8qL2vts
	n2mMduma5hYqUH3m4sQQJ8DWbgFwYHaq37LgLq3kThMm7S8WjFHrssLLzJ4kJnt5T0Ta
	VbJJT/KJlMjfL89FM2Y7MpfN2AueyZsSJAX/FxE4PDOealqpt2unqgpQrn57Qs147JAm
	MuFJAlg4gCbXVr0edtvRdY9lcvc6qyIi4VS5Iz2peZkVxG9clkwvvwzTG5ZAxMrmEiO6
	+AGw==
Date: Wed, 17 Aug 2016 15:59:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160817155956.00a9b6d5@xeon-e3>
In-Reply-To: <20160623025036.5260-1-somasissounds@gmail.com>
References: <20160623025036.5260-1-somasissounds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Fix building on musl libc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kylie McClain <somasissounds@gmail.com>
Cc: bridge@lists.linux-foundation.org, Kylie McClain <somasis@exherbo.org>

On Wed, 22 Jun 2016 22:50:36 -0400
Kylie McClain <somasissounds@gmail.com> wrote:

> From: Kylie McClain <somasis@exherbo.org>
> 
> - Silence warnings:
>   errno.h is defined by POSIX, sys/errno.h is a glibcism, same with
>   fcntl.h vs. sys/fcntl.h
> - Use standard types rather than _GNU_SOURCE-exposed types
>   u_int16_t -> uint16_t
>   u_int8_t -> uint8_t
> ---
>  brctl/brctl.c               |  2 +-
>  libbridge/libbridge.h       | 13 +++++++------
>  libbridge/libbridge_devif.c |  2 +-
>  libbridge/libbridge_if.c    |  2 +-
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 

Applied to git tree, but won't be spinning a new release anytime soon.

