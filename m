Date: Tue, 11 Nov 2008 09:11:05 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20081111091105.2de861bb@extreme>
In-Reply-To: <BLU149-W3001C3DF281B41D8F506DB8B150@phx.gbl>
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
	<fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
	<BLU149-W2552C09A3C56CF923B077E8B1A0@phx.gbl>
	<fed120860811100228x3fbff600l4e672635d4c260e3@mail.gmail.com>
	<BLU149-W34C4000F51A9F3DBDA06EC8B1A0@phx.gbl>
	<20081110083501.55aa10fd@extreme>
	<BLU149-W3001C3DF281B41D8F506DB8B150@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fahim Akhter <akhter.fahim@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 11 Nov 2008 12:16:34 +0500
Fahim Akhter <akhter.fahim@hotmail.com> wrote:

> 
> P.S according to the little knowledge I have netfilters decide the fate of the packet by looking at the header not the data, but I need the data to decide what to do with the packet.

Netfilter modules can see the whole packet 
