Return-Path: <hare@suse.de>
Message-ID: <53479F8B.9020002@suse.de>
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
References: <5590ca8b.f19f.1454fb2f747.Coremail.kernelluck@163.com>
In-Reply-To: <5590ca8b.f19f.1454fb2f747.Coremail.kernelluck@163.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] sometimes ping fails when enable stp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 11 Apr 2014 07:53:50 -0000
To: "longguang.yue" <kernelluck@163.com>, virtualization <virtualization@lists.linux-foundation.org>, bridge <bridge@lists.linux-foundation.org>

On 04/11/2014 09:31 AM, longguang.yue wrote:
> hi,all
> sometimes ping fails when enable stp , why?
> =20
Probably stp initialisation isn't yet finished, and the switch will
block any traffic until that happens.
During that time any traffic will return with -EHOSTUNREACH.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
