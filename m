Message-ID: <45E5C2BE.3070808@candelatech.com>
Date: Wed, 28 Feb 2007 09:58:22 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <34d8b2fe0702270811h5098894aia299857618e8dde@mail.gmail.com>
	<34d8b2fe0702280625y1d1184f2h2f1f0792ac105977@mail.gmail.com>
In-Reply-To: <34d8b2fe0702280625y1d1184f2h2f1f0792ac105977@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] About support of 802.1p standard into 2.6 linux Bridge
 code
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

Louis Croisez wrote:
> Hello,
> i would like to know if the 802.1p (QoS for Ethernet frames) standard 
> is implemented into last 2.6 kernel Bridging code?
> Cheers,
> Louis.
It's implemented in the VLAN code, at least as far as being able to map 
a socket priority to a vlan priority.  There
is no special queue handling based on the priority bits at this time, at 
least in vlan code.

Ben

> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>   


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


