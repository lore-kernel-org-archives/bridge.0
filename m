Date: Thu, 2 Oct 2003 16:00:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20031002160041.47053537.shemminger@osdl.org>
In-Reply-To: <p05111b00bba2061773df@[10.96.96.13]>
References: <20030927202200.GA612@man.beta.es>
	<p05111b00bba2061773df@[10.96.96.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hannes Schulz <schulz@schwaar.com>
Cc: linux-net@vger.kernel.org, marcelo.tosatti@cyclades.com, Santiago Garcia Mantinan <manty@manty.net>, bridge@osdl.org

When it fails are there any errors in the TCP stats or loopback driver?
Look at 'netstat -s -p tcp' and 'netstat -i lo'
