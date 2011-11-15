Return-Path: <martin.volf.42@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=gHofQo0bPqmQSWIKJZg3EhpvJkpceaJs8rrfohqLQkc=;
	b=T0fl1hCAhwNAeY2Eg7uOSJegozjM2zk59U+r/AxjBePHvVLgygwTDYePL6b0zye0YX
	DqdQu2Sm7uwpIY7NbHAmvlbYFNq028QiFGfIFP7Nekt1/OmmfeQRVg66cbB7tz5+qcJJ
	qjva2HQo3khIJ0lO6As3jTi6f97GkXoewPSO8=
MIME-Version: 1.0
In-Reply-To: <20111115100914.0c9540be@nehalam.linuxnetplumber.net>
References: <CAM1AHpSuruDx3CxzK=Med0iyxxwu7wxgRZib7yhBMiCVKXqzeA@mail.gmail.com>
	<4EC23EE7.2010606@intel.com>
	<20111115100914.0c9540be@nehalam.linuxnetplumber.net>
Message-ID: <CAM1AHpQsYz=y8m_RSzfPkGXGFZ8rQQE0Q+pmfbRb6K0v-jQ91w@mail.gmail.com>
From: Martin Volf <martin.volf.42@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] [RFT] bridge: checksum not updated after pull
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 15 Nov 2011 19:50:25 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "wcang@sfc.wide.ad.jp" <wcang@sfc.wide.ad.jp>, "davem@davemloft.net" <davem@davemloft.net>

On 15 November 2011 19:09, Stephen Hemminger <shemminger@vyatta.com> wrote:
> I think this is what is necessary, please test.
...

Hello,

with the patch on top of 3.1.1 I no longer get the "hw csum failure"
message. I don't know how to test IPv6 multicast, but IPv6 ND and
SLAAC is correctly passing through the bridge.

Thanks!

Martin Volf
