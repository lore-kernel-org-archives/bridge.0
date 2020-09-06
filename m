Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jx/2AQJ19GgF5GMqfvKOGk4UBA5cUToV3mcDGBZKY0M=;
 b=fhmW+fC2PmioUdyyeuNSunMjhlR4qJ2lZZGtlYKxTJR3KMU9Ujv6Lhc7LgQ4BBVHlG
 NyZWuH8GlRz54X0DUGci+HlYmYOQif6XyoPJPiDDZx6/suJwWtNKVNcKjnG6aNJwMrKQ
 8VavQF54Sr+nIii/kNlkV2PW2OuMxlGb3cwWc=
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-7-nikolay@cumulusnetworks.com>
 <20200906140136.77ae178d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4f8ec4f0-6311-3b18-c7c4-a3a49b8d94b4@cumulusnetworks.com>
Date: Mon, 7 Sep 2020 00:14:51 +0300
MIME-Version: 1.0
In-Reply-To: <20200906140136.77ae178d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 06/15] net: bridge: mcast: add
 support for group query retransmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 9/7/20 12:01 AM, Jakub Kicinski wrote:
> On Sat,  5 Sep 2020 11:24:01 +0300 Nikolay Aleksandrov wrote:
>> We need to be able to retransmit group-specific and group-and-source
>> specific queries. The new timer takes care of those.
> 
> What guarantees that timer will not use pg after free? Do timer
> callbacks hold the RCU read lock?
> 

See the last patch, it guarantees no entry timer will be used when it's freed.
