Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:subject:to:cc:from:message-id;
	bh=lXFeAJE60fifFYxfGpI2NxvAbx5BMDCiCHe0eoui8LU=;
	b=OvTGQGM5jwUwBkkJqn8oK7kfy9iaTTr5PqwWBRi8QUUgpbELOHPJNspECDcKPsLEwN
	w/mNAs5V0rAw4bCg6VUQuhBmSVHZJh3/PR/GagT/BLski2D0xTY9ISzMwAb347T4zSrA
	o+ZrlKMkYnx1OKty8dOpovPkqoCTAZdLXXFu4=
Date: Fri, 20 Jul 2018 20:47:26 +0300
In-Reply-To: <708CD30E-1F32-4769-A1C1-FE77762FA172@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
	<20180720085725.6dc1743d@xeon-e3>
	<8D6C03E0-6596-4B5B-9B6C-5684B5DFE148@cumulusnetworks.com>
	<20180720102044.16b92166@xeon-e3>
	<708CD30E-1F32-4769-A1C1-FE77762FA172@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <C6B4C1AB-7991-45B3-9649-CC4A36D878A8@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
	sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On July 20, 2018 8:26:36 PM GMT+03:00, Nikolay Aleksandrov <nikolay@cumulus=
networks=2Ecom> wrote:
>On July 20, 2018 8:20:44 PM GMT+03:00, Stephen Hemminger
><stephen@networkplumber=2Eorg> wrote:
>>On Fri, 20 Jul 2018 20:14:43 +0300
>>Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom> wrote:
>>
>>> >Casting away the const on the buf variable is going to cause
>>warnings
>>> >and should not be necessary=2E
>>> > =20
>>>=20
>>> It doesn't when it's casted like that, the new line is changed to
>>null byte so we need to drop=20
>>> the const=2E
>>
>>Then change store function to take a char *?
>
>Sure, will do=2E

Acrually I can't change sysfs_ops store prototype=2E=20
That is the reason the bond also casts the ptr=2E



