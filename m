Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jz9ts4SCtKZj37NIPf8q4/BPLrwc/osDKFjhv7rsDeI=;
 b=tRkgNoX4yJhq2d5BmyfWy8mpkG4kC5+XKVPug3Pci6UF4uEEf2kXBaopNRhVs4i3DW
 k0Gc8JctiyRHscnKKtxyXy5h7B7cLp62sXtrkkW3jpAv7dOYt7AIjzRhbIRC01dOZLc7
 Q6LA/wbFEkb8Rvjtu9J0IPZO2TsfFbvbo9uVaXMgJ8AeXjQXie0GgkuU3M338nu3Wzm6
 67CzBqx5fx7TkVKfIH33zZ5zo5W/8anAfqWUyKanHz5rVYSeCLi390iZ4fUYKq4Zkjn0
 5s6Dx5EKZI/usIGZKq/+d6pqsNErugR12MOKa666p5TEIdizgzGkExzmyVtkvbqXEvAt
 ua0Q==
Date: Mon, 24 Feb 2020 08:54:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200224085427.0358ed8c@hermes.lan>
In-Reply-To: <20200224164622.1472051-1-nikolay@cumulusnetworks.com>
References: <83cadec7-d659-cf2a-c0c0-a85d2f6503bc@cumulusnetworks.com>
 <20200224164622.1472051-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix stale eth hdr pointer
 in br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Mon, 24 Feb 2020 18:46:22 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> -	eth = eth_hdr(skb);
>  	skb_pull(skb, ETH_HLEN)

you could just swap these two lines.
