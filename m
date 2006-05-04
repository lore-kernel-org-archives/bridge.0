From: "Paul C. Diem" <PCDiem@FoxValley.net>
Subject: RE: [Bridge] Interface Statistics
Date: Thu, 4 May 2006 17:01:40 -0500
Message-ID: <FFEPKIHJDEDDAAFOFDGFMEJGCBAA.PCDiem@FoxValley.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060504143624.324274f6@localhost.localdomain>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Yes, I did. ip -s link show always shows zero for multicast packets too.

Paul C. Diem
PCDiem@FoxValley.net

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org]
Sent: Thursday, May 04, 2006 4:36 PM
To: Paul C. Diem
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] Interface Statistics


On Thu, 4 May 2006 16:16:33 -0500
"Paul C. Diem" <PCDiem@foxvalley.net> wrote:

> Is there anyway to get interface statistics such as multicast packets
> received/transmitted for the individual interfaces in a bridge or for the
> bridge as a whole?
>
> Do the Receive/Transmit bytes/packets counters in /proc/net/dev reflect
all
> packets received/transmitted (even those that were only bridged) or only
> those actually targeted to/irrigated from the server?
>
> Thank you,
>
> Paul C. Diem
> PCDiem@FoxValley.net
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

did you look at 'ip -s link'?

--
No virus found in this incoming message.
Checked by AVG Free Edition.
Version: 7.1.385 / Virus Database: 268.5.2/329 - Release Date: 5/2/2006

