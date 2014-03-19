Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=xwIvNwM3pe8zidtYBJMKtjWJehg0xbIu+e7Iomz1FbE=;
	b=azWZF0gnCrC5c7p1zmLpYs2z+GfIJt6U6Njykbs4LUjCXej0rG42uy338On1YWJqCL
	kg9erg+qJTXcskFq3MdWdbZYTEiN+V+I9mv53O1F99F4hYXE/z8XSh8g5X9x30eCHBRq
	Tg/vQzES5DykK/yqe/uIiAz08vUXoJiHbQKiBGEOWuJu7vXEtYt06qEviMAFf8mNhAuO
	GMcFAdNUNMXcjkoA5bYK0wWeN83w8vQAB7jbPnkHZiK+VbFvfuMKwT17r4RRn4eX+Qws
	5nuWAepPNK8/5FYqE7JzatWJ7/lLiWw7SslalP6bI/+/SrjscSOD6IUYWZ3vpotfjxu4
	ORQw==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <5328E802.3030901@lab.ntt.co.jp>
References: <1394680527-28970-1-git-send-email-mcgrof@do-not-panic.com>
	<1394680527-28970-2-git-send-email-mcgrof@do-not-panic.com>
	<5328E802.3030901@lab.ntt.co.jp>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 18 Mar 2014 17:50:18 -0700
Message-ID: <CAB=NE6X2eZFLWBN1acf=d75T_K2YM_OK3oaXEPu-hwpUJEmwkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH 1/3] bridge: preserve random init MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Tue, Mar 18, 2014 at 5:42 PM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> nit,
> If the last detached port happens to have the same addr as
> random_init_addr, this seems to call br_stp_change_bridge_id() even
> though bridge_id is not changed.

Ah good point.

> Shouldn't the assignment of random_init_addr be done before the check of
> "no change"?

Good question, should we even allow two ports to have the same MAC
address or should we complain and refuse to add it? If so that should
mean we should also have to monitor any manual address changes or
events for address changes on the ports.

Stephen?

  Luis
