Message-ID: <4002E392.3010300@hcssystems.com>
Date: Mon, 12 Jan 2004 13:12:34 -0500
From: Josh Wyatt <Josh.Wyatt@hcssystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Max length of bridge device name?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi all,

Does anyone know the maximum length of the interface name created by 'brctl addbr'?  How about any other restrictions on 
usable alphanumerics, for example is "-" (dash) or "_" (underscore) allowed, commas, periods, etc allowed?

Most docs I see refer to this as br0, but I'd like to use more descriptive names, such as vlan_105, etc.

Thanks in advance,
Josh

