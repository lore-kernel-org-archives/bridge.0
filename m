Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=qYmKPHJ5z4rcHu2PUquy77TU4W4swubbH5XaNbW5MXY=;
	b=g8apASJqxjM6ZxF3GhX1KGO0hlEVKYNS8CP3fFNba62UB53jlwQjjRTADdtYhtSI4r
	v9z5vqf3bS5AIaEGyhKL4V83QvjhMH5vEBeGIOwfWkvRzti+gs0Nq5NmaOieS2oMNkPM
	+L2lbMCmfZdGzhXB+DEuaQqz5mQ9oKV4wuGsQ=
References: <cover.1458134414.git.lucien.xin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <56E96DFC.7090608@cumulusnetworks.com>
Date: Wed, 16 Mar 2016 15:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1458134414.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/6] bridge: support sending rntl info
 when we set attributes through sysfs/ioctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

On 03/16/2016 02:34 PM, Xin Long wrote:
> This patchset is used to support sending rntl info to user in some places,
> and ensure that whenever those attributes change internally or from sysfs,
> that a netlink notification is sent out to listeners.
> 
> It also make some adjustment in bridge sysfs so that we can implement this
> easily.
> 
> I've done some tests on this patchset, like:
> [br_sysfs]
>   1. change all the attribute values of br or brif:
>   $ echo $value > /sys/class/net/br0/bridge/{*}
>   $ echo $value > /sys/class/net/br0/brif/eth1/{*}
> 
>   2. meanwhile, on another terminal to observe the msg:
>   $ bridge monitor
> 
> [br_ioctl]
>   1. in bridge-utils package, do some changes in br_set, let brctl command
>   use ioctl to set attribute:
>          if ((ret = set_sysfs(path, value)) < 0) { -->
>          if (1) {
> 
>   $ brctl set*
> 
>   2. meanwhile, on another terminal to observe the msg:
>   $ bridge monitor
> 
> This test covers all the attributes that brctl and sysfs support to set.
> 

Please also include the bridge maintainers (CCed).


