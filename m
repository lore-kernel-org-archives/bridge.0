Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=rwj6o4WwWRJq3ZF4fLst9TnGaye9Y4gG73+Y26/u8y8=;
	b=Vqhsa/Ph07IX3dH4OYaYdT572Cg4qP1zvyB7akxdCavbIfoZyBO2g8jOVWorT6tFvn
	EcMwZO6wVm8O3N7N2PFFI+CH9NfpCSyfCfpd3GsMTb40GLh388ycbIQUPl5DKF8MjLll
	fDnL8JWHvcAAEG37GDbUiAJ+AmkznOvfiWOEHBoSILTQJXX5O34tlFT5oky5Fe8Me+E5
	xRMabRJP3LF+hqkB2rJf4PngIyq8J8cy8FG25gzcrHXik1Ginqh4z4UiJGCDI2ETRPeH
	Gf8tixoT5UY7wnZNWHCFTsmRE0HJoySv+QpM7OJvemeXGHajNSLHgWABVaV++Vq2U+UB
	4g+w==
Date: Sat, 10 Mar 2018 08:32:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180310083234.47db5f06@xeon-e3>
In-Reply-To: <20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/5] bridge: initialize port flags
 with switchdev defaults
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On Fri,  9 Mar 2018 19:03:04 -0800
Igor Mitsyanko <igor.mitsyanko.os@quantenna.com> wrote:

> Default bridge port flags for switchdev devices can be different from
> what is used in bridging core. Get default value from switchdev itself
> on port initialization.
> 
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> ---

Yes hardware devices may come it with different default values.
But the user experience on Linux needs to be consistent.

Instead, it makes more sense to me for each device driver using switchdev
to program to the values that it sees in the bridge.

Please revise this.
