Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=6VzkEhJBRPyDZHOlVoFIXGfCJpDyGc7YMRrbGxI2Xnw=;
	b=NNOyMiCoF/ReoVV2vzMI0I9qcjvK1KQJiBQB0+bliqVLkwxjCaDckUmx28pfOcXjWD
	mwa/k+Gx5e/sbByL2Un923Gg+7h4Kn4LwJe7IiBYeltuXW1aiadTtAa7LfFrwux/GQ/4
	LaoLTuEIEUK0ODyn8Hkf0Z2Ui+fT/WzxR5/Mvacd8g3BN2O2G9cnIa0lcIEBgNvgbLgd
	dJ7Pe6yThvUkz0QUw3mkNaGa9GPqHgCQGTJANcKj/bnTjaSwc/DomQhYfhAqob53ba8A
	3kGb6j8nGjV2He1V4NdEyQzGtC7wy3wfYkthvTddgKYb1iyckieq5i8ehfZiT5+tvLkk
	boDg==
Message-ID: <1396078847.1756.1.camel@localhost.localdomain>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Sat, 29 Mar 2014 16:40:47 +0900
In-Reply-To: <20140328093457.5d25b9a3@samsung-9>
References: <1395987680-8151-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20140328093457.5d25b9a3@samsung-9>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix memory leak in br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>

On Fri, 2014-03-28 at 09:34 -0700, Stephen Hemminger wrote:
> On Fri, 28 Mar 2014 15:21:19 +0900
> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
> 
> > When a frame is rejected by br_allowed_ingress(), the skb is not freed.
> > 
...
> Increment dev->tx_dropped?

OK, I'll rework it.

Thanks,
Toshiaki Makita

