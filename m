Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604080387;
 bh=fiX1GZZW0VTWVzXnWU7zdBSZ50Wkkk7mejibE0CkdiY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MVu0kaAvE2wNNEOpn24cdcrKUr7wR9hPCh8U/U1elyPWxSiwguHNQIvA7gsA7MqOP
 3catVGDL6ZN05N6NYGqCe+ts5RURK8jJsDIylSnD36zV3YWReaudQOs22edVXB7a+I
 cXPRXnX16hvd3ESgDN9wYJrL3pZqzKSQPF7f/ktk=
Date: Fri, 30 Oct 2020 10:53:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201030105305.719eac75@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201027185934.227040-1-razor@blackwall.org>
References: <20201027185934.227040-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/16] selftests: net: bridge: add
 tests for IGMPv3
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

On Tue, 27 Oct 2020 20:59:18 +0200 Nikolay Aleksandrov wrote:
> This set adds tests for the bridge's new IGMPv3 support. The tests use
> precooked packets which are sent via mausezahn and the resulting state
> after each test is checked for proper X,Y sets, (*,G) source list, source
> list entry timers, (S,G) existence and flags, packet forwarding and
> blocking, exclude group expiration and (*,G) auto-add. The first 3 patches
> prepare the existing IGMPv2 tests, then patch 4 adds new helpers which are
> used throughout the rest of the v3 tests.
> The following new tests are added:
>  - base case: IGMPv3 report 239.10.10.10 is_include (A)
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
> The variable names and set notation are the same as per RFC 3376,
> for more information check RFC 3376 sections 4.2.15 and 6.4.1.
> MLDv2 tests will be added by a separate patch-set.

Applied, thanks Nik!
