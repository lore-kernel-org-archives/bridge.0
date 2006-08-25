Message-ID: <8cbd14710608250422w16b92f21g595e02f32c0a2ea0@mail.gmail.com>
Date: Fri, 25 Aug 2006 07:22:37 -0400
From: Skept <impossibleprobability@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Bridge-MIB and 802.1d linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello folks,

Is it possible to gather snmp statistics from a linux bridge using the
Bridge-MIB [rfc 1493 or rfc 4188]?

The difference between the two rfc's, I think, is the latter's ability
to support SMIv2 syntax. I have started with extracting the MIB from
the rfc's and generating dot1dbridge.c and .h files using mib2c.
Then i realized that the .c and .h files so generated are just
templates and that I need to edit them to
add semantics [ie. how should the agent collect the statistics from
the bridge/kernel. code?]

So, to expand the original question, if the linux bridge code does
support collection of snmp stats, where do I start to learn more about
it[I would like to enable Bridge-MIB support in the snmp agent]?

Skept
