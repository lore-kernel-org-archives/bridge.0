Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=c98cUptVmJxE5gRFF2lQKZ85lSUZABTYRlTJayTa7PU=;
 b=YTeVouU4/q9oN7V71uXAknPNxVcrKdeLiadmUfvC7R1ASQTSCrq+Pr81B2gfXGypD1
 zXYjYZoWD2EYMGFNl0KWPG+93X+2ERGhoESqyBCXQIx/f9vQhccpfNqWvz73GCeEZeRM
 S8NJQwqRpQdm9ZKK8yuqcx/9NeuyYHyfrAnQvVobl8yWvweJg7zAd+6JTna32uoo3QP5
 XaN+X+rWzLzIqSyw+dc1io9te6PAfdjL813YFZcXQSDnttbHyOcVRND/DG5BRabxuAmX
 92Tp3FqR1GSAvRnEOw0azh3nM488Eem7uqoOub0QJmUzOpxDv3kLqbN5/oBCfhkGAf64
 nKSw==
Date: Mon, 9 Dec 2019 18:15:47 -0500
Message-ID: <20191209181547.GB1256102@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20191209143423.7acb2f4b@hermes.lan>
References: <20191209211841.1239497-1-vivien.didelot@gmail.com>
 <20191209211841.1239497-2-vivien.didelot@gmail.com>
 <20191209143423.7acb2f4b@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH iproute2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Mon, 9 Dec 2019 14:34:23 -0800, Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Mon,  9 Dec 2019 16:18:41 -0500
> Vivien Didelot <vivien.didelot@gmail.com> wrote:
> 
> > diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> > index 31fc51bd..e7f2bb78 100644
> > --- a/include/uapi/linux/if_bridge.h
> > +++ b/include/uapi/linux/if_bridge.h
> 
> These headers are semi-automatically updated from the kernel.
> Do not make changes here.

OK, I respin the series with only the minimal changes required for iproute2
to compile correctly.

Thank you,
Vivien
