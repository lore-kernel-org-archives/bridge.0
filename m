Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761435; x=1634297435;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cA6QBKhjqXc9apBjlCYNPW0rtpxCtWcB+v3escExznM=;
 b=W80LQkKQS1FbutAapBEIh3gzKQsSz87eQAqyXkvmIU3ctGM4UnLsyxeN
 Qo9Vk3LDCxe8kXLXQ8NKfh0QADLrd47y9TPX7v+lP1eJ2rXiQgqXBk/J1
 1Wgx4/BMJZDcVj8h24lDAkiTtKkADvI1sWtJ2fXsARjwDOHonJSgCd5L8
 8zwqC6vH0oeQlgAl2owzz+Oyx5rAFc8ZaB0LVEfsGypsqZ5MQ+x9TgKpy
 b67MWi0tBSfw3YCt1H6NWMwCRerLH2rCEIJNPlyFllfDe9gVZeVMMtZ1b
 BTpIW9t3LXOqVQWDlY1MotnUVmPZhfZc7mps/vokPiHe1ZwwHZFbTQwjC g==;
Date: Thu, 15 Oct 2020 11:28:53 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112853.42vcj4bjbg7syoyd@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-6-henrik.bjoernlund@microchip.com>
 <20201014155958.12e38308@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014155958.12e38308@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 05/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame TX added.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for your review. Comments below.
Regards
Henrik

The 10/14/2020 15:59, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:23 +0000 Henrik Bjoernlund wrote:
> > +     skb = dev_alloc_skb(CFM_CCM_MAX_FRAME_LENGTH);
> > +     if (!skb)
> > +             return NULL;
> > +
> > +     rcu_read_lock();
> > +     b_port = rcu_dereference(mep->b_port);
> > +     if (!b_port) {
> > +             rcu_read_unlock();
> > +             return NULL;
> > +     }
> 
> At a quick scan I noticed you appear to be leaking the skb here.
> So let me point out some more nit picks.

I have changed as requested.

-- 
/Henrik
