Date: Mon, 16 Apr 2007 11:11:37 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070416111137.2b046ae8@dxpl.pdx.osdl.net>
In-Reply-To: <1176676171.3713.16.camel@collymore.citylink.co.nz>
References: <1176676171.3713.16.camel@collymore.citylink.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Feature enhancement - Disable unicast flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dylan Hall <dylan@citylink.co.nz>
Cc: bridge@linux-foundation.org

On Mon, 16 Apr 2007 10:29:31 +1200
Dylan Hall <dylan@citylink.co.nz> wrote:

> For the project I'm working on I require that the bridging code not
> flood unicast frames when the destination mac address is unknown,
> similar to Cisco's "switchport block unicast" feature
> (http://www.cisco.com/en/US/products/ps6406/products_configuration_guide_chapter09186a00805a761a.html#wp1087814).
> 
> I have produced a small patch (against 2.6.20.4) to control this feature
> per bridge (rather than per port like a Cisco).
> 
> Have I gone about implementing this correctly?
> 
> Is this something other people may find useful, and hence worth
> incorporating into the mainstream code?
> 
> Is it worth the effort of taking this one step further, and controlling
> the behaviour per port rather than per bridge?
> 
> Thanks,
> 
> Dylan
> 
> 
> 

Maybe. But this kind of thing is better done with a ebtables module.
That way it can be more easily integrated with other security stuff.
