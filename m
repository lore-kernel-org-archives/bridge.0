Message-ID: <30be90270511141352o305e13bfn99cc3931f620d394@mail.gmail.com>
Date: Mon, 14 Nov 2005 16:52:13 -0500
From: Hai Wang <u2.ireland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge performance issue
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello everyone,


    I encountered a performance issue regarding bridge, please let me
know your thoughts:


        I am doing the stress test against bridge with two scenarios

        I created two br2684 interfaces (nas0 and nas1) on a Linux box
and create 1 VLAN interfaces (eth0.32) on eth0 and then do the
followings

       1. Bridge nas0 and eth0.32
       2. Bridge nas0, nas1 and eth0.32



Start 100% traffic load on nas0 for scenario 1, no traffic loss Start
100% traffic load on nas0 and nas1 for scenario 2, 40-50% traffic
mis-inserted /duplicated.

If I added more nas interfaces to the bridge

# of the mis-inserted/duplicated packets will increase up to 100%

I am on kernel 2.4.31,

Please let me know your thoughts!

Thanks!

--

