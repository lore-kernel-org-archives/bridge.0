Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-transfer-encoding;
	bh=GyNEkN1SbJZ0p314uqjjzUom9Ab1dUUA/y2mQV6Rd2Q=;
	b=OQ/m1bUCX8IGHxdnpsnc22jazI0W6xLji/kpLH6cYR4DaZ+PoHRrNNVlocUAbGVjFL
	YGYC7IoUAxmKBBlQPPzrefV4v5dGHVvrPxGVueL+gpmzC0s4Dc1V3K3AJrT4o69G7Kik
	xYY2M6+eTXiSpEG3bFWLzbkgYQOo5SycXlzi8=
Message-ID: <5899CA80.8030108@cumulusnetworks.com>
Date: Tue, 07 Feb 2017 05:24:16 -0800
From: Roopa Prabhu <roopa@cumulusnetworks.com>
MIME-Version: 1.0
References: <c341a60f-f3d1-29f6-b825-5ebd1432e5b9@cumulusnetworks.com>
	<1486468006-8080-1-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1486468006-8080-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: tunnel: fix attribute checks
	in br_parse_vlan_tunnel_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Colin Ian King <colin.king@canonical.com>

On 2/7/17, 3:46 AM, Nikolay Aleksandrov wrote:
> These checks should go after the attributes have been parsed otherwise
> we're using tb uninitialized.
>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  
ouch, am surprised i did not catch this. Thanks Colin and Nikolay.
