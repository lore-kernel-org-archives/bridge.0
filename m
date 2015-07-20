Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=ZSaZp5GdJ3BgyUxpOqAa58ZquGpDHfcblrb0Wiwd/do=;
	b=OJ90aSruKkwZtDgBRgAXOuE6uwK+iDhHfJvl2A+oHFPBj5289W0UyoriOV0MhnnojI
	RmVlFvc3qi9DOqWDN0yxBFe6jemA4l5zkvVkPJWfVLNiduK9SCQzPAZIicwhkSnUzLEi
	xf61tjCVDUgL2dyQ3Bwj+Wh7xo9q71QEG1s8Q=
Message-ID: <55AD5BA6.3050101@cumulusnetworks.com>
Date: Mon, 20 Jul 2015 22:35:50 +0200
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
MIME-Version: 1.0
References: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
	<20150720.124939.1328394717828737521.davem@davemloft.net>
In-Reply-To: <20150720.124939.1328394717828737521.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] bridge: multicast: temp and perm
 entries behaviour enhancements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au

On 07/20/2015 09:49 PM, David Miller wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Wed, 15 Jul 2015 07:16:49 -0700
> 
>> Hi,
>> Patch 01 adds a notify when a group is deleted via br_multicast_del_pg()
>> (on expire, on device delete or on device down).
>> Patch 02 changes how bridge device and bridge port delete and down/up are
>> handled. Until now on bridge down all groups were flushed, now only the
>> temp ones are (same for port), perm entries are flushed only on port or
>> bridge removal.
> 
> Series applied, but if patch #2 breaks things for anyone depending upon the
> old behavior of flushing all entries I will have to revert.
> 

Okay, understood.
