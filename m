Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version;
	bh=fAK5ZnkiNP56cStVtrb82hm5UIysuZtJkQDBdJFSk0g=;
	b=VMIcoMbMqGV7eFoneCYVg5lEjvbtP4+YrzDOCTTm/6Bf5+A/iJE2TyXxMlIJ7MkM8v
	mtx0xTyT5cBWMdtlXAbT25EJgK4D9H8SDzakH3hGs4icUQBb3MOT3qiVOCKRb8ENPmIW
	vH/0R17UD6tXX/lE13VRWJAumX6RK+jwMs2+Uql6BFph5HOZBraTHeUGKGDfIyeE89gJ
	VgEiHoGMOfWObCJYHusiy01m5gmHh3f7uis2FG9OYQ7BitcJ9PU7rxZ8hm/wAhuFcR6p
	dM9efrFdEBfu1Eppu2SBEbY7TV5ocHnCC+yWJNV2j5m2sro0spguYbUaruZptpccf8MG
	YRdw==
Message-ID: <1386257826.30495.196.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 05 Dec 2013 07:37:06 -0800
In-Reply-To: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
References: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [patch net/stable v2] br: fix use of ->rx_handler_data
 in code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: jtluka@redhat.com, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

On Thu, 2013-12-05 at 16:27 +0100, Jiri Pirko wrote:

> RH bugzilla reference: https://bugzilla.redhat.com/show_bug.cgi?id=1025770
> 
> Reported-by: Laine Stump <laine@redhat.com>
> Debugged-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> ---

Acked-by: Eric Dumazet <edumazet@google.com>

Thanks


