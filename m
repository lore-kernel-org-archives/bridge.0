Return-Path: <amine.kherbouche@6wind.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=6wind-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=LNB4MwArLL0pEJf9Ml4gTFyIKbrIEdBDLuXAlIHwVbI=;
	b=keKYld7R6lJ2HTEkMG8XAwNy+edj9FQX1QvbDVY184Mkm6ieH1hh7Z50SAMB68PvIl
	QED6HgZSYE2UIu7PUAfls/H3sE0BCTj876FJzqvcnI2jCm3DA0xwdK+d2RkDd//yqpep
	yxgrRirzb/x9vVaMhxV0fjHCY5NRg6SuS3h3Ms3WG+yX7jXEwzoRwqGev3xLfHp6AoNi
	GOx5fJEvGyZapmzoUbVScTNSOwKXojP+2QsW4ls6bSdxCfOJ9PIP2LGjmctyWgN94oRf
	IJYnwd1vuJ7kqTg99XFHgCfWrratJc1BBKOdpntAOFRuN0uU4hB+Y9VfygYZj30WhB2m
	Yo5Q==
References: <20170821171523.951260-1-equinox@diac24.net>
	<20170821171523.951260-7-equinox@diac24.net>
From: Amine Kherbouche <amine.kherbouche@6wind.com>
Message-ID: <025f7bf9-72d6-53c4-6680-4e20313aecf2@6wind.com>
MIME-Version: 1.0
In-Reply-To: <20170821171523.951260-7-equinox@diac24.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 6/6] mpls: VPLS support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 28 Aug 2017 09:21:39 -0000
To: David Lamparter <equinox@diac24.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: roopa@cumulusnetworks.com

any opinion on vpls driver path ?

On 08/21/2017 07:15 PM, David Lamparter wrote:
> [work-in-progress, works but needs changes]
> [v2: refactored lots of things, e.g. dst_metadata, no more genetlink]
> [v4: removed pointless include/net/vpls.h, squashed pseudowire control
> word support, squashed netlink lwtunnel access bits]
>
> Signed-off-by: David Lamparter <equinox@diac24.net>
> ---
>  include/net/dst_metadata.h    |  24 ++
>  include/uapi/linux/lwtunnel.h |   8 +
>  net/core/lwtunnel.c           |   1 +
>  net/mpls/Kconfig              |  11 +
>  net/mpls/Makefile             |   1 +
>  net/mpls/vpls.c               | 550 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 595 insertions(+)
>  create mode 100644 net/mpls/vpls.c
