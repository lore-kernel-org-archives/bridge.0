Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ley0ZV8wDk+WyRdH1QdkNT8cH2cyBlW9JyOpeJgzHEI=;
 b=dS2FsnITrxu/HHyNu4GkyWB5mSo2cwU9z3MazXFOzlF0WolGpGWbhAQozatjm/EOH4
 ToCzVzAcX/93SoX4NpmSoSVykXyY49TZmB/iJdUD92GAo2HiECTfY6QsZTrH4Q42m+qj
 OfZbBR6kj8ea0i8RQxtuZXSXL2wIN3Qbb0Wy7P1ksm2gAXoDKYTX6sGLN/4egmAtAcjV
 tEum9+ZE987fULyC6UzYRrBQsido6zeY/dqnvRpvKtxiRywyZIb6Qa669eNDcpe/ebst
 EuXOd0JPASJPY31vdx3+1eOgdEuCcN/To+E/ckNU6LAApUzah2LIDZccnWu9B7dFFBOy
 BnOg==
Date: Mon, 7 Jun 2021 09:59:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20210607095913.32c17900@hermes.local>
In-Reply-To: <CAE2MWkkL9x+FRzggdOSPcyFpguwP9VuQPD9AJWLTsfLzaLodfQ@mail.gmail.com>
References: <CAE2MWkkL9x+FRzggdOSPcyFpguwP9VuQPD9AJWLTsfLzaLodfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] net: bridge: multicast: Renaming of flag
	BRIDGE_IGMP_SNOOPING
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Kernel <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Mon, 7 Jun 2021 21:29:34 +0530
Ujjal Roy <royujjal@gmail.com> wrote:

> Hi Stephen,
> 
> Can we rename this flag BRIDGE_IGMP_SNOOPING into something like
> BRIDGE_MULTICAST_SNOOPING/BRIDGE_MCAST_SNOOPING? I am starting this
> thread because this BRIDGE_IGMP_SNOOPING flag holds information about
> IGMP only but not about MLD. Or this is not a common name to describe
> both IGMP and MLD. Please let me know about my concern, so that I can
> change the code and submit a patch.
> 
> Thanks,
> UjjaL Roy

It is part of user API at this point so not possible to remove old definition.
