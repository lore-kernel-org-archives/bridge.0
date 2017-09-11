Return-Path: <amine.kherbouche@6wind.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=6wind-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=wBMWm490ahezJ/IA+4M+qw76Cbb1xhTctN7XFvFhuQY=;
	b=pzeP7oAUzi91UgtokmTXQshamcy4Xd0VZRi5DVHNs7NOazZLOCTjukfOpjxEcS0wLL
	+WUiEilh6u4gbPQ5DrtU0bmSbDLvM0RfIrj+yByEo+ykRYuT4I0WL1Tb3jYfvDuAFhfq
	jxJ1N7Y1dK5klVv5/gp10vjoOJoCKLfM4XqYZKZk2GY420XqHQGCSozN0HpYuPVdBIxH
	hhqJ59xSIMmwZEQIJQrfmbBpCf+7ksXbuPLWTIBbwc/EKqEEexmTUp9DfppqSeQ+14/v
	akLHrK2BuehnhtGJxGxSCChaNUqbskETojdEEHg4Na/hYTTfPrVal/GtQ3+Wt48/sGWR
	P1FA==
References: <20170821171523.951260-1-equinox@diac24.net>
From: Amine Kherbouche <amine.kherbouche@6wind.com>
Message-ID: <6a538120-1941-7e81-c942-e97adeff2e3d@6wind.com>
MIME-Version: 1.0
In-Reply-To: <20170821171523.951260-1-equinox@diac24.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC net-next v2] bridge lwtunnel, VPLS & NVGRE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 11 Sep 2017 08:02:25 -0000
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: roopa@cumulusnetworks.com

Hi David,

Do you plan to send a v3?

On 21/08/2017 18:15, David Lamparter wrote:
> Hi all,
>
>
> this is an update on the earlier "[RFC net-next] VPLS support".  Note
> I've changed the subject lines on some of the patches to better reflect
> what they really do (tbh the earlier subject lines were crap.)
>
> As previously, iproute2 / FRR patches are at:
> - https://github.com/eqvinox/vpls-iproute2
> - https://github.com/opensourcerouting/frr/commits/vpls
> while this patchset is also available at:
> - https://github.com/eqvinox/vpls-linux-kernel
> (but please be aware that I'm amending and rebasing commits)
