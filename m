Date: Mon, 12 Jan 2004 13:41:48 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Max length of bridge device name?
Message-Id: <20040112134148.2049ef83.shemminger@osdl.org>
In-Reply-To: <4002E392.3010300@hcssystems.com>
References: <4002E392.3010300@hcssystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Mon, 12 Jan 2004 13:12:34 -0500
Josh Wyatt <Josh.Wyatt@hcssystems.com> wrote:

> Hi all,
> 
> Does anyone know the maximum length of the interface name created by 'brctl addbr'? 
	IFNAMSIZ-1 = 15 chars

 How about any other restrictions on 
> usable alphanumerics, for example is "-" (dash) or "_" (underscore) allowed, commas, periods, etc allowed?

Well all should work (except "." and "..").

> Most docs I see refer to this as br0, but I'd like to use more descriptive names, such as vlan_105, etc.
> 
> Thanks in advance,
> Josh
