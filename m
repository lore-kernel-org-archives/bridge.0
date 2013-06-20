Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:x-mailer:content-transfer-encoding:mime-version;
	bh=byKKvl6+7EUQePfDqckW+RiyxtUsoaYyguRkZzf2F4E=;
	b=F5fdyM1rnaiC8AgPcnrOBb7gf6mTl8a+9zBhGB1g3PeJjkH9bJt7s0EPtdZ6tkYnFQ
	pnp4iS3TuYKMCnGsdBLCmkxDfNCkii0JJMJExmsyxrVmYR5YIDa/lw2yEZ9K7LPGdeQQ
	0IT0UFEazZiW3SLx73O8uKyQT6aXU6lsv07os6JJa2kVr97leQC63Vddw/yghiQWnpHF
	bgEJcI4IbzlEp03h1APfJ5Mx7PuUxWkk3XcuoXscc00Yu6rJxOZpsK7WuS8j7PAL6RdS
	9MV2oHf4kFdhEggbC8Pvyf0LMAD+/dgO9wnk9Ayb8eRFW/o/+7puoYhbCmeExWZyYt2R
	FWFA==
Message-ID: <1371716040.3252.389.camel@edumazet-glaptop>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Jun 2013 01:14:00 -0700
In-Reply-To: <51C2B3A9.5070904@gmail.com>
References: <51C2710D.2060405@gmail.com> <51C2721B.9050603@gmail.com>
	<1371704129.3252.356.camel@edumazet-glaptop>
	<51C2A8AA.5010902@gmail.com>
	<1371713342.3252.371.camel@edumazet-glaptop>
	<51C2B3A9.5070904@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH] net bridge: add null pointer check, fix panic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xiaoming gao <gxm.linux.kernel@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Thu, 2013-06-20 at 15:47 +0800, xiaoming gao wrote:

> 
> if you remove the test on FF_BRIDGE_PORT, and br_port_get_rcu never returns NULL, the problem is fixed.
> but the codes in mainline is still bugged, am i right??
> by the way, kernel-stable 3.0 and 3.4 tree also have this bug, and is very easily to reproduce.

Commit 00cfec37484761a4 has to be backported anyway, if not already
backported.

I would rather fix things properly, instead of adding defensive code.


