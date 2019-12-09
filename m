Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=21rRHFPvjZK3p9sHxqd95tcXX0jutqdzXHdUpefK27I=;
 b=xLXQN/34gfNkqvPZgEQz5Mq2sz3JTIRFKKDEMrDkmN9SNnGVD53BM76EFsQtm821z3
 hm9bSpkCxRvaWD1KfrbJ7hlkJ8VA5ZlaTFYQk0XbDUXYYMx5rCg1d1ikljOOpsjdJkPS
 hjHSCCvznTKb6zNNsxcgeIfoCwMyt81+ZLXU2qboyA2JCpkA+mLfutk1hi1BV6IeDk6L
 TmiMYvyJqB0bK7OVhFYbnhwGPtWwSC+FB1Pek0CPLTRBaaC3dplL3ozbtwJj6mBgwOvD
 ETQiaILMphm0U2UVlSF6pcFu87BIJo7ISADkLLAvGwQJQtR7oSc3LS19I6lhW8NQnfIV
 8nmQ==
Date: Mon, 9 Dec 2019 14:34:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20191209143423.7acb2f4b@hermes.lan>
In-Reply-To: <20191209211841.1239497-2-vivien.didelot@gmail.com>
References: <20191209211841.1239497-1-vivien.didelot@gmail.com>
 <20191209211841.1239497-2-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Mon,  9 Dec 2019 16:18:41 -0500
Vivien Didelot <vivien.didelot@gmail.com> wrote:

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index 31fc51bd..e7f2bb78 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h

These headers are semi-automatically updated from the kernel.
Do not make changes here.
