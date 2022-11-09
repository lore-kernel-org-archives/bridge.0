Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CFEF40340
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AE2C401D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyOEs71AmoxlwRiKiZ98pdROGJ7d0FHsUwtImU/ttlM=;
 b=wfl1a/21cr09/6H2ZJqmzxoX2i397OZeYWgy1mWaA10g+PbLSY1gc8xxbc5J6LqnX7
 9jdYaw+YFl/bQ+/tWZLF8AomKx74wywPnCIUgGYpacCNHMVgashcp/8QURFGtY+KCCRQ
 3kV0qBN2TfWJ2dCc1dVHnhaIYOI3L5Fsbb7BtYCiwPe5w4CwlzcnbuT9Pmu+zbuyGfVu
 UT3PqfIcVK+jdeyFzoMnkFeW+SY+nn26r1kL7tWLVX81b6lwNgN5rwBjD71OJzqRxIgp
 RP8GlZu9QUxJpGZC/Z6dvoQrbs0Ur9eWI6Qrt0SgWNfjerzBx94J+E38VmVcFX0AXolB
 bhlg==
Date: Wed, 9 Nov 2022 08:51:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20221109085109.6b0f87d3@hermes.local>
In-Reply-To: <nWfVbvdboX65r0xMXv0iZCj8TH7c8vStvilCD3Ilx5Y42yoHh34rJHJBMy8y4HhqXWXM0n3tLhLD870c863UjI20HBSxM8qwJlLMxuPjg0g=@protonmail.com>
References: <nWfVbvdboX65r0xMXv0iZCj8TH7c8vStvilCD3Ilx5Y42yoHh34rJHJBMy8y4HhqXWXM0n3tLhLD870c863UjI20HBSxM8qwJlLMxuPjg0g=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] How to connect more than 200 interfaces to a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ali Shirvani via Bridge <bridge@lists.linux-foundation.org>

On Wed, 09 Nov 2022 10:51:27 +0000
Ali Shirvani via Bridge <bridge@lists.linux-foundation.org> wrote:

> Hello everyone,
> 
> It seems we reach the Linux bridge limitation on the number of interfaces in a single bridge. Currently, we have 210 tap interface in a bridge, and we suffer from more than 50% packet loss when we ping the IP address of the virtual machine that uses one of the tap interfaces in the bridge.
> Do you know how we can connect more than 200 VMs virtual interfaces to a bridge?
> 
> Best regards,
> Ali
> 
> Sent with [Proton Mail](https://proton.me/) secure email.

The upper limit on interfaces per bridge should be 1023.
That limitation comes from spanning tree.

You might bet able to improve performance by disabling flooding to those tap devices.
Normally, any broadcast/unknown/multicast must be copied and flooded to each interface.
