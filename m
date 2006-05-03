Date: Wed, 3 May 2006 11:47:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] MAC/ID setting
Message-ID: <20060503114754.23bf8ffc@localhost.localdomain>
In-Reply-To: <1146567369.26014.69.camel@lucas>
References: <1146567369.26014.69.camel@lucas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Petr Rajchman <p.rajchman@satca.net>
Cc: bridge@osdl.org

On Tue, 02 May 2006 12:56:09 +0200
Petr Rajchman <p.rajchman@satca.net> wrote:

> Hi,
> I am not able to find the relevant links about IFHWADDR feature for the
> bridge. It only inherits the MAC from the first interface added into the
> bridge and it is not possible to change it via ip/ifconfig. What is the
> matter?
> Thank you,
> Peter
> 

The bridge mac id can now be set to any of the devices in the bridge
(2.6.16 or later).  Arbitrary addresses won't work because it would
confuse STP and other systems.
