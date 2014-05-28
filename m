Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=FVFpZ9pEWGwXOFuy4VZpY4Lq7NSZEtzkVGmJs1xQAxY=;
	b=I+guHkAQlkg/qQNApLbkxZUt83FnCM+vhwV/yzydq99VXYqBis1cccBBdS/OwYo7/8
	B4/JQtHkjQp902f9vV0gxh2HFCgSMBEC6M1S07yHnzSUb88Dq9cYkcdbGTkulG2rex3k
	gbxmYvMCrXEplT7VYZqQl+EwRH8NA6mECMWQNzLC0HraxCesUZX+QGY2KKMafERl+7ll
	6Mf8AVqn6vCDQTDgmkQqNx36XqZNWIn0MVTy5PlQ7Qz/GkEabdDRs5mWSPliX9jK1Cdu
	hIbPtUoZbFcc5b9IPPmWc7OXzURHu0hoxs8LWUPWijlgvihw4p2aqejl4n+99lz3chb3
	OX/A==
Message-ID: <1401287570.1873.4.camel@localhost.localdomain>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Wed, 28 May 2014 23:32:50 +0900
In-Reply-To: <5385EC5D.40106@redhat.com>
References: <1401084953-10135-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<5385EC5D.40106@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Prevent insertion of FDB entry
 with disallowed vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>

On Wed, 2014-05-28 at 10:02 -0400, Vlad Yasevich wrote:
...
> 
> This is very similar to br_allow_ingress(), so may be you can
> re-factor so that we only have 1 such function...

Yes.. indeed, this looks redundant.
What bothered me is br_allowed_ingress() modifies or drops frames but
I'm not expecting it here.
Maybe we can hand a hint to br_allowed_ingress so that it doesn't modify
the skb?

Thanks,
Toshiaki Makita

