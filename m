Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KALLKX
 Jw6PszKdVDnPzpoMAy7qra0xYV8ojuu9kkgbI=; b=N4d11yXAmmw2n6ezNfUyi8
 fHk7K3XhR3++GmTjzuFaYiAyshzuP4wE58SjPOm+md0qQZT7KrNGdXDQY+VZrY1z
 ZO17h985WLQJ6dAr5zrAx0c2KoyV0pGuvKTz2pFrbrJzOM1ZPGkV2642yG0Wsv67
 VqO85RqvD0t15Ep5FC7QbqMTd+BqdRDGerruvXswuct30Z6Bah/SAgRMK/PKLW4h
 Z5aCqcO8kGm4hsfBr+CUG0pZQJHh1S0R0z3H7EI6jMTFsnh17xGs6kwTjMIOpH4e
 xJm1za4/4UAHuJUfztp+IbQDez8eRiiZLaggwxbNi2H+kMnRRP+mUCeAc3iLxSHw
 ==
Date: Thu, 30 Apr 2020 18:57:44 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20200430155744.GB4076599@splinter>
References: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
 <20200430105551.GA4068275@splinter>
 <8be48925-4e09-fe9c-6d8c-8675ede5fce7@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be48925-4e09-fe9c-6d8c-8675ede5fce7@profihost.ag>
Subject: Re: [Bridge] BUG: soft lockup while deleting tap interface from
 vlan aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

On Thu, Apr 30, 2020 at 03:18:18PM +0200, Stefan Priebe - Profihost AG wrote:
> Great! This indeed solves the problem.

Thanks for reporting and testing!
