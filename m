MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.01.1008041343200.32671@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<alpine.LSU.2.01.1008041343200.32671@obet.zrqbmnf.qr>
Date: Thu, 5 Aug 2010 16:12:48 +0530
Message-ID: <AANLkTim_=pmLER7v=rePa=ikP2Fv0bKJkN4aafNXUTNo@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org

On Wed, Aug 4, 2010 at 5:13 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
> On Wednesday 2010-08-04 13:05, ratheesh k wrote:
>
>>I =A0googled and =A0understood that "If we =A0DROP a packet at BROUTER ch=
ain
>>, it will be passed to upper layer =A0and netfilter subsystem will
>>process those packets .
>>
>>What will happen, =A0if we drop a packet at PREROUTING chain =A0of ebtabl=
es ?
>
> Depends on the table you are referring to.
>

Ok .
Could you please answer below question . i got little confused here .
This answer may solve some confusion .

What is the difference between  droppin a Pkt in Brouting chain of
Broute table and  Drop a Pkt in  nat prerouing chain of ebtables . Or
are they having same effect ? .
