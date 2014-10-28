Return-Path: <oliver.graute@neuhaus.de>
In-Reply-To: <544F4F11.5030804@tataelxsi.co.in>
References: <OF305789BF.DDFC2700-ONC1257D78.004C279D-C1257D78.004EAE6C@LocalDomain>
	<OF45925193.8424278E-ONC1257D7F.0027FD6A-C1257D7F.0028C7F9@neuhaus.de>
	<544F4F11.5030804@tataelxsi.co.in>
Message-ID: <OF41891AA7.1CFF0179-ONC1257D7F.002FDAFB-C1257D7F.0031A765@neuhaus.de>
From: Oliver.Graute@neuhaus.de
Date: Tue, 28 Oct 2014 10:02:10 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="----D2EFEE8515868E044219A5D00F67F4BB"
Subject: [Bridge] Antwort: Re: Antwort: RSTP daemon and Marvel switch
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: satyanarayanam@tataelxsi.co.in
Cc: bridge@lists.linux-foundation.org

This is an S/MIME signed message

------D2EFEE8515868E044219A5D00F67F4BB
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF7ECDFBC5C6B8f9e8a93df938690918c4EBBF7ECDFBC5C6B"
Content-Disposition: inline

--0__=4EBBF7ECDFBC5C6B8f9e8a93df938690918c4EBBF7ECDFBC5C6B
Content-type: text/plain; charset=US-ASCII

Hello Satya.

ok fine, I allready tried to adapt my Device Tree Bindings for my IMX28
Board according to this example:

https://www.kernel.org/doc/Documentation/devicetree/bindings/net/dsa/dsa.txt

But at Linux bootup nothing dsa related is detected.

dmesg | grep -E "mii|dsa"
[    2.432681] libphy: fec_enet_mii_bus: probed
[   18.605055] eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=800f0000.etherne:01, irq=-1)
[   19.373633] eth1: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=800f0000.etherne:03, irq=-1)


Here is my DTS part of the Device Tree:

/*
 *   Marvell Distributed Switch Architecture Device Tree Bindings
 *
 *   A DSA node can contain multiple switch chips which are therefore child
nodes of
 *   the parent DSA node. The maximum number of allowed child nodes is 4
 */

dsa@0 {
        compatible = "marvell,dsa";
        #address-cells = <2>;
        #size-cells = <0>;

        interrupts = <10>;
        dsa,ethernet = <&mac1>;
       // dsa,mii-bus = <&mii_bus0>;
         dsa,mii-bus = <&ethphy1>;
       //  dsa,mii-bus = <&mdio>;

        switch@0 {
            #address-cells = <1>;
            #size-cells = <0>;
            //reg = <16 0>;   /* MDIO address 16, switch 0 in tree */
            reg = <5 0>;   /* MDIO address 16, switch 0 in tree */

            port@0 {
                reg = <0>;
                label = "lan1";
                phy-handle = <&ethphy1>;
            };

            port@1 {
                reg = <1>;
                label = "lan2";
            };

            port@2 {
                reg = <2>;
                label = "lan3";
            };

            port@3 {
                reg = <3>;
                label = "lan4";
            };

            port@4 {
                reg = <4>;
                label = "lan5";
            };

            port@5 {
                reg = <5>;
                label = "cpu";
            };
        };
            switch1uplink: port@0 {
                reg = <0>;
                label = "dsa";
                link = <&switch0uplink>;
            };
        };
*/
    };


/*
 *   The MDIO is a bus to which the PHY devices are connected. For each
 *   device that exists on this bus, a child node should be created.  See
 *   the definition of the PHY node below for an example of how to define a
PHY.

    mdio {
               #address-cells = <1>;
               #size-cells = <0>;
              device_type = "mdio";
              compatible = "marvell,mv64360-mdio";

              ethernet-phy@0 {
                     ......
              };
        };
 */
mdio {
        #address-cells = <1>;
        #size-cells = <0>;
          device_type = "mdio";
        compatible = "marvell,mv64360-mdio";
        status = "okay";

         ethphy0: ethernet-phy@0 {
                 reg = <0>;
         };

         ethphy1: ethernet-phy@1 {
                 reg = <1>;

                compatible = "marvell,88e1149r";
                marvell,reg-init = <3 0x10 0 0x5777>,
                                   <3 0x11 0 0x00aa>,
                                   <3 0x12 0 0x4105>,
                                   <3 0x13 0 0x0a60>;
                };

                 //reg = <0xff>; /* No PHY attached */
                 //speed = <1000>;
                 //duple = <1>;
         };


Best regards,

Oliver

>
>     Yes , you need DSA to distinguish from which port a frame arrived.
>     DSA driver in Linux is available in below path, "drivers/net/dsa/"
>   for reference " http://lxr.free-electrons.com/source/drivers/net/dsa/"
>
> Thank you
> Satya
>
> On 10/28/2014 12:55 PM, Oliver.Graute@neuhaus.de wrote:
> >
> > Hello Satya,
> >
> >
> > > RSTP daemon runs in application  and stops the kernel stp and informs
> > > to pass the packets to application layer.
> > > RSTP daemon waits in raw socket with stp filter.
> > > You just need to change the a bit code for port wise that all.
> >
> > ok thanks,
> >
> > do I need the DSA (Distributed Switch Architecture) driver support to
> > distinguish from which port a frame arrived? Currently, I can not
> > distinguish these frames.
> >
> > I can't find DSA drivers in the mainline Linux Kernel for the Marvel
> > Switch Chip (88E6071) . Bur there are drivers for other DSA supported
> > chips from marvel (88E6060).
> >
> > Related Question:
> >
> > How do I customize my device tree bindings (dts file) for DSA support?
> >
> >
> > Best regards,
> >
> > Oliver Graute
> >
>
--0__=4EBBF7ECDFBC5C6B8f9e8a93df938690918c4EBBF7ECDFBC5C6B
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Hello Satya.</tt><br>
<br>
<tt>ok fine, I allready tried to adapt my Device Tree Bindings for my IMX28 Board according to this example:</tt><br>
<br>
<tt><a href="https://www.kernel.org/doc/Documentation/devicetree/bindings/net/dsa/dsa.txt">https://www.kernel.org/doc/Documentation/devicetree/bindings/net/dsa/dsa.txt</a></tt><br>
<br>
<tt>But at Linux bootup nothing dsa related is detected. </tt><br>
<br>
<tt>dmesg | grep -E &quot;mii|dsa&quot;</tt><br>
<tt>[ &nbsp; &nbsp;2.432681] libphy: fec_enet_mii_bus: probed</tt><br>
<tt>[ &nbsp; 18.605055] eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=800f0000.etherne:01, irq=-1)</tt><br>
<tt>[ &nbsp; 19.373633] eth1: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=800f0000.etherne:03, irq=-1)</tt><br>
<br>
<br>
<tt>Here is my DTS part of the Device Tree:</tt><br>
<br>
<tt>/*</tt><br>
<tt>&nbsp;* &nbsp; Marvell Distributed Switch Architecture Device Tree Bindings</tt><br>
<tt>&nbsp;* &nbsp; </tt><br>
<tt>&nbsp;* &nbsp; A DSA node can contain multiple switch chips which are therefore child nodes of</tt><br>
<tt>&nbsp;* &nbsp; the parent DSA node. The maximum number of allowed child nodes is 4</tt><br>
<tt>&nbsp;*/</tt><br>
<br>
<tt>dsa@0 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; compatible = &quot;marvell,dsa&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; #address-cells = &lt;2&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; #size-cells = &lt;0&gt;;</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; interrupts = &lt;10&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; dsa,ethernet = &lt;&amp;mac1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp;// dsa,mii-bus = &lt;&amp;mii_bus0&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dsa,mii-bus = &lt;&amp;ethphy1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp;// &nbsp;dsa,mii-bus = &lt;&amp;mdio&gt;;</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; switch@0 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #address-cells = &lt;1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #size-cells = &lt;0&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //reg = &lt;16 0&gt;; &nbsp; /* MDIO address 16, switch 0 in tree */</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;5 0&gt;; &nbsp; /* MDIO address 16, switch 0 in tree */</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@0 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;0&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;lan1&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; phy-handle = &lt;&amp;ethphy1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@1 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;lan2&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@2 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;2&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;lan3&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@3 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;3&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;lan4&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@4 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;4&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;lan5&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port@5 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;5&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;cpu&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; switch1uplink: port@0 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg = &lt;0&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; label = &quot;dsa&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; link = &lt;&amp;switch0uplink&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>*/</tt><br>
<tt>&nbsp; &nbsp; };</tt><br>
<br>
<br>
<tt>/*</tt><br>
<tt>&nbsp;* &nbsp; The MDIO is a bus to which the PHY devices are connected. For each</tt><br>
<tt>&nbsp;* &nbsp; device that exists on this bus, a child node should be created. &nbsp;See</tt><br>
<tt>&nbsp;* &nbsp; the definition of the PHY node below for an example of how to define a PHY.</tt><br>
<br>
<tt>&nbsp; &nbsp; mdio {</tt><br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp; #address-cells = &lt;1&gt;;</tt><br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp; #size-cells = &lt;0&gt;;</tt><br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp;device_type = &quot;mdio&quot;;</tt><br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp;compatible = &quot;marvell,mv64360-mdio&quot;;</tt><br>
<br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp;ethernet-phy@0 {</tt><br>
<tt>		 &nbsp; &nbsp; &nbsp; &nbsp; ......</tt><br>
<tt>	 &nbsp; &nbsp; &nbsp; &nbsp;};</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<tt>&nbsp;*/</tt><br>
<tt>mdio {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; #address-cells = &lt;1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; #size-cells = &lt;0&gt;;</tt><br>
<tt>	 &nbsp; &nbsp;device_type = &quot;mdio&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; compatible = &quot;marvell,mv64360-mdio&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; status = &quot;okay&quot;;</tt><br>
<tt>&nbsp;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ethphy0: ethernet-phy@0 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg = &lt;0&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};</tt><br>
<tt>&nbsp;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ethphy1: ethernet-phy@1 {</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg = &lt;1&gt;;</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible = &quot;marvell,88e1149r&quot;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; marvell,reg-init = &lt;3 0x10 0 0x5777&gt;,</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;3 0x11 0 0x00aa&gt;,</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;3 0x12 0 0x4105&gt;,</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;3 0x13 0 0x0a60&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; };</tt><br>
<br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;//reg = &lt;0xff&gt;; /* No PHY attached */</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;//speed = &lt;1000&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;//duple = &lt;1&gt;;</tt><br>
<tt>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;};</tt><br>
<br>
<br>
<tt>Best regards,</tt><br>
<br>
<tt>Oliver</tt><br>
<tt><br>
&gt; <br>
&gt; &nbsp; &nbsp; Yes , you need DSA to distinguish from which port a frame arrived.<br>
&gt; &nbsp; &nbsp; DSA driver in Linux is available in below path, &quot;drivers/net/dsa/&quot;<br>
&gt; &nbsp; for reference &quot; <a href="http://lxr.free-electrons.com/source/drivers/net/dsa/">http://lxr.free-electrons.com/source/drivers/net/dsa/</a>&quot;<br>
&gt; <br>
&gt; Thank you<br>
&gt; Satya<br>
&gt; <br>
&gt; On 10/28/2014 12:55 PM, Oliver.Graute@neuhaus.de wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hello Satya,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; RSTP daemon runs in application &nbsp;and stops the kernel stp and informs<br>
&gt; &gt; &gt; to pass the packets to application layer.<br>
&gt; &gt; &gt; RSTP daemon waits in raw socket with stp filter.<br>
&gt; &gt; &gt; You just need to change the a bit code for port wise that all.<br>
&gt; &gt;<br>
&gt; &gt; ok thanks,<br>
&gt; &gt;<br>
&gt; &gt; do I need the DSA (Distributed Switch Architecture) driver support to <br>
&gt; &gt; distinguish from which port a frame arrived? Currently, I can not <br>
&gt; &gt; distinguish these frames.<br>
&gt; &gt;<br>
&gt; &gt; I can't find DSA drivers in the mainline Linux Kernel for the Marvel <br>
&gt; &gt; Switch Chip (88E6071) . Bur there are drivers for other DSA supported <br>
&gt; &gt; chips from marvel (88E6060).<br>
&gt; &gt;<br>
&gt; &gt; Related Question:<br>
&gt; &gt;<br>
&gt; &gt; How do I customize my device tree bindings (dts file) for DSA support?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt;<br>
&gt; &gt; Oliver Graute<br>
&gt; &gt;<br>
&gt; <br>
</tt></body></html>
--0__=4EBBF7ECDFBC5C6B8f9e8a93df938690918c4EBBF7ECDFBC5C6B--

------D2EFEE8515868E044219A5D00F67F4BB
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIJYwYJKoZIhvcNAQcCoIIJVDCCCVACAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCB2QwggOhMIICiaADAgECAgRTKpskMA0GCSqGSIb3DQEBBQUAMGUxGDAW
BgNVBAMTD2Z3MXQubmV1aGF1cy5kZTEQMA4GA1UECxMHR2F0ZXdheTEqMCgGA1UE
ChMhRHIgTmV1aGF1cyBUZWxla29tbXVuaWthdGlvbiBHbWJIMQswCQYDVQQGEwJk
ZTAeFw0xNDAzMjAwNzM5MTZaFw0zNDAzMTUwNzM5MTZaMIGMMQswCQYDVQQGEwJk
ZTEqMCgGA1UEChMhRHIgTmV1aGF1cyBUZWxla29tbXVuaWthdGlvbiBHbWJIMRAw
DgYDVQQLEwdHYXRld2F5MRYwFAYDVQQDEw1PbGl2ZXIgR3JhdXRlMScwJQYJKoZI
hvcNAQkBFhhPbGl2ZXIuR3JhdXRlQG5ldWhhdXMuZGUwgZ8wDQYJKoZIhvcNAQEB
BQADgY0AMIGJAoGBANnANTj15llaogP5PS5qQZfo8FpeQCMWO4RcCitX5G8OrTR+
bilKdhylqIRbb2J9eYbBgrhwRIJwk696ZB3N0eJhk4WHXarBXUx2CKqLuRymTSGZ
sIhWRkRUXUVc5067J4xL0/4yCj4+U7s+S7V/9bmQqB2Wk+if28tK6cGEpdIPAgMB
AAGjgbQwgbEwCQYDVR0TBAIwADARBglghkgBhvhCAQEEBAMCBLAwLAYJYIZIAYb4
QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBQ5
rpfOC5wJcJPg5vtZJ96Nt0UgKTAfBgNVHSMEGDAWgBTs+JXPYwn0sdl6NX256a/J
cW9YoDAjBgNVHREEHDAagRhPbGl2ZXIuR3JhdXRlQG5ldWhhdXMuZGUwDQYJKoZI
hvcNAQEFBQADggEBAHM02XacfrbOAa0f1e+HE940vZaE5xgEUPcOaTCe6Wdu3nK3
OGAGIAnHfQ130XKDW1/w2XY7EoSwK8IkGRN7PJY/oZ214mcBrMBa/oB2i3uhhV9J
bxG5cRnGyY10BpkFYag/6Jd9YI+4HjhKCDp/YB2MbslphU/Dw8c30qS/UOYzC5Ix
4QyN/qK6ykGnvJAV2K120IYiO3O8W4TpdloF0ZMUtExTpDgFgFQdLtDbaMVzAzxz
1nnncN6uf+Yd4B8Rz6H3xn4El5TYkyPCY/S0N0TBeFVih8pzh7g88YqfZMQ9msIS
SCCEl5BpLDHbwAaBV5cHjkrvbXO7RnO56tmZ9wcwggO7MIICo6ADAgECAhRTTkX+
umlHGjEnbVuCyKf7ZDxsAzANBgkqhkiG9w0BAQUFADBlMRgwFgYDVQQDEw9mdzF0
Lm5ldWhhdXMuZGUxEDAOBgNVBAsTB0dhdGV3YXkxKjAoBgNVBAoTIURyIE5ldWhh
dXMgVGVsZWtvbW11bmlrYXRpb24gR21iSDELMAkGA1UEBhMCZGUwHhcNMDcwMzE5
MTYyOTI5WhcNMjcwMzE0MTYyOTI5WjBlMRgwFgYDVQQDEw9mdzF0Lm5ldWhhdXMu
ZGUxEDAOBgNVBAsTB0dhdGV3YXkxKjAoBgNVBAoTIURyIE5ldWhhdXMgVGVsZWtv
bW11bmlrYXRpb24gR21iSDELMAkGA1UEBhMCZGUwggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDO/vqAga4J46o9WABfVwTFOYiUyA7GMnRK5Nck4InVoQYy
Bd3kZGANQhSFocmiBd0ptwVaJ5CdZivSe1K/FzhNVygo5UyL2C85uqrb51H7pVFV
93yuB399V6sMnZnMYkoQpfbGdFfeQx2YlopLkvvJPQK8I9qbpK/XqjxHcnQh21d4
D890UWUAWGIDk4iwwyII75k32HJO2D+fiygjzfoT0azyEfoYH9jUSA3tk3wQX3N3
tCLxsCKta1TIaAyb7eUvXlk3rbrWh5UYVuUMaCo8tEC6mLvoG+gJbAhKePOV4DMM
OpplBXCw/bj2CXK7q/3TbJ507jO56EBt/q+7+nqpAgMBAAGjYzBhMA8GA1UdEwEB
/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBTs+JXPYwn0sdl6NX25
6a/JcW9YoDAfBgNVHSMEGDAWgBTs+JXPYwn0sdl6NX256a/JcW9YoDANBgkqhkiG
9w0BAQUFAAOCAQEARW5yvbZw9SgSKfhT+ty1dS3DSdMZdEs4BL2q7lGq/kWM5Wec
F2U4ygvUd/H2Bw4S7n566gTgMxarh0v3cxw36HqDlT1/ZNsPD1653WLDAVNe1/qu
RrTMRrXwABa/G9W7T4eOBjcjsX/id5NR3y9UPbbAkozx0TRSO16puxd8tMcAW/p2
zzueErvCJU5OwhGvbDgjhp0eXRKkifkyCeC9ETda8+FaZhKI9Wsq3FW0fONnYhQu
i4lIHNPbkLJuL3a10pRSgZamkjy/gTCeiNj2JyrpMD9SrSe/gxguAElQ5Z2xGlpN
vfWmJ8HR4vZBvGvfBq/1c5gjsHiCHVq9sHNdajGCAccwggHDAgEBMG0wZTEYMBYG
A1UEAxMPZncxdC5uZXVoYXVzLmRlMRAwDgYDVQQLEwdHYXRld2F5MSowKAYDVQQK
EyFEciBOZXVoYXVzIFRlbGVrb21tdW5pa2F0aW9uIEdtYkgxCzAJBgNVBAYTAmRl
AgRTKpskMAkGBSsOAwIaBQCggbEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTQxMDI4MDkwMjMwWjAjBgkqhkiG9w0BCQQxFgQUE6/5
MnfpbSkI3sa5i71Jmi6CRvUwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICASgwDQYJKoZIhvcNAQEBBQAEgYATTHrU1ptnPSj9RDGXt4L7o73tbRvgA6vi
JFv8rqlPKZwpwZkIv3RuoYF66o7klOvDwM66cdrhYaKoRW9qM3l0UIr1Vl68iHtA
CTYFdmenQmoYJLbposCL7fU4YNz2oMAq37XTvcYHMpUPnu/0lSJy/mnjzlmu2Q0E
y7cYeohV8Q==

------D2EFEE8515868E044219A5D00F67F4BB--

