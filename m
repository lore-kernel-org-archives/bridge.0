Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604537917;
 bh=OvKVeunpCGu7hkS0Lk0dXb/miDXw7CVsk1xe7Gi6Qiw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SjK+bbDxrfWtLRGXpSlGTTFnkBRgQDjTO0H7YSr7f3VKI2D0Y5vEreIHsUM9haPap
 yFIorjlP3NsAwMbEh+2BLIA4MiGS9O5rRLSnC1GbFmslkuODVNZGP/eSswlXjpPUub
 n2/C3ZYUt9KpjBgdlBwa0RTPIVW2wDtRfO4kvqmg=
Date: Wed, 4 Nov 2020 16:58:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201104165836.4f0f721d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201103172412.1044840-1-razor@blackwall.org>
References: <20201103172412.1044840-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/16] selftests: net: bridge: add
 tests for MLDv2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

On Tue,  3 Nov 2020 19:23:56 +0200 Nikolay Aleksandrov wrote:
> This is the second selftests patch-set for the new multicast functionality
> which adds tests for the bridge's MLDv2 support. The tests use full
> precooked packets which are sent via mausezahn and the resulting state
> after each test is checked for proper X,Y sets, (*,G) source list, source
> list entry timers, (S,G) existence and flags, packet forwarding and
> blocking, exclude group expiration and (*,G) auto-add. The first 3 patches
> factor out common functions which are used by IGMPv3 tests in lib.sh and
> add support for IPv6 test UDP packet, then patch 4 adds the first test with
> the initial MLDv2 setup.
> The following new tests are added:
>  - base case: MLDv2 report ff02::cc is_include
>  - include -> allow report
>  - include -> is_include report
>  - include -> is_exclude report
>  - include -> to_exclude report
>  - exclude -> allow report
>  - exclude -> is_include report
>  - exclude -> is_exclude report
>  - exclude -> to_exclude report
>  - include -> block report
>  - exclude -> block report
>  - exclude timeout (move to include + entry deletion)
>  - S,G port entry automatic add to a *,G,exclude port
> 
> The variable names and set notation are the same as per RFC 3810,
> for more information check RFC 3810 sections 2.3 and 7.

Applied, thank you!
