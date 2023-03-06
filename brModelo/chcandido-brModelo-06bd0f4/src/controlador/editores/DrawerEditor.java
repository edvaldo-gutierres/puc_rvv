/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador.editores;

import controlador.Controler;
import controlador.Editor;
import controlador.inspector.InspectorProperty;
import desenho.FormaElementar;
import desenho.preDiagrama.baseDrawerItem;
import desenho.preDiagrama.iBaseDrawer;
import java.awt.Dimension;
import java.awt.Point;
import java.util.ArrayList;
import javax.swing.DefaultListModel;
import javax.swing.event.ListSelectionEvent;
import util.BrLogger;

/**
 *
 * @author ccandido
 */
public class DrawerEditor extends javax.swing.JDialog implements Editor.iParaOutrosInspectors {

    /**
     * Creates new form DrawerEditor2
     *
     * @param parent
     * @param modal
     */
    public DrawerEditor(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        inspector1.setDicas(inspectorDicas1);
    }

    /**
     * This method is called from within the constructor to initialize the form. WARNING: Do NOT modify this code. The content of this method is always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jToolBar1 = new javax.swing.JToolBar();
        btnNovo = new javax.swing.JButton();
        jSeparator2 = new javax.swing.JToolBar.Separator();
        btnDuplique = new javax.swing.JButton();
        jSeparator3 = new javax.swing.JToolBar.Separator();
        btnExcluir = new javax.swing.JButton();
        jSeparator1 = new javax.swing.JToolBar.Separator();
        btnSubir = new javax.swing.JButton();
        btnDescer = new javax.swing.JButton();
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel2 = new javax.swing.JPanel();
        jSplitPane2 = new javax.swing.JSplitPane();
        jScrollPane1 = new javax.swing.JScrollPane();
        Lista = new javax.swing.JList();
        jScrollPane2 = new javax.swing.JScrollPane();
        jPanel3 = new javax.swing.JPanel();
        painelPintador1 = new controlador.apoios.PainelPintador();
        jSplitPane3 = new javax.swing.JSplitPane();
        inspector1 = new controlador.inspector.Inspector();
        inspectorDicas1 = new controlador.inspector.InspectorDicas();
        jPanel1 = new javax.swing.JPanel();
        btnPronto = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jToolBar1.setFloatable(false);
        jToolBar1.setRollover(true);

        java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("principal/Formularios_pt_BR"); // NOI18N
        btnNovo.setText(bundle.getString("DrawerEditor.Novo")); // NOI18N
        btnNovo.setFocusable(false);
        btnNovo.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnNovo.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnNovo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNovoActionPerformed(evt);
            }
        });
        jToolBar1.add(btnNovo);
        jToolBar1.add(jSeparator2);

        btnDuplique.setText(bundle.getString("DrawerEditor.Duplique")); // NOI18N
        btnDuplique.setFocusable(false);
        btnDuplique.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnDuplique.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnDuplique.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDupliqueActionPerformed(evt);
            }
        });
        jToolBar1.add(btnDuplique);
        jToolBar1.add(jSeparator3);

        btnExcluir.setText(bundle.getString("DrawerEditor.Excluir")); // NOI18N
        btnExcluir.setFocusable(false);
        btnExcluir.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnExcluir.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnExcluir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExcluirActionPerformed(evt);
            }
        });
        jToolBar1.add(btnExcluir);
        jToolBar1.add(jSeparator1);

        btnSubir.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/up.png"))); // NOI18N
        btnSubir.setFocusable(false);
        btnSubir.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnSubir.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnSubir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSubirActionPerformed(evt);
            }
        });
        jToolBar1.add(btnSubir);

        btnDescer.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagens/down.png"))); // NOI18N
        btnDescer.setFocusable(false);
        btnDescer.setHorizontalTextPosition(javax.swing.SwingConstants.CENTER);
        btnDescer.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);
        btnDescer.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDescerActionPerformed(evt);
            }
        });
        jToolBar1.add(btnDescer);

        jSplitPane1.setDividerLocation(360);
        jSplitPane1.setResizeWeight(1.0);

        jSplitPane2.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        jScrollPane1.setMinimumSize(new java.awt.Dimension(35, 130));

        Lista.setModel(new javax.swing.AbstractListModel() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public Object getElementAt(int i) { return strings[i]; }
        });
        jScrollPane1.setViewportView(Lista);

        jSplitPane2.setTopComponent(jScrollPane1);

        javax.swing.GroupLayout painelPintador1Layout = new javax.swing.GroupLayout(painelPintador1);
        painelPintador1.setLayout(painelPintador1Layout);
        painelPintador1Layout.setHorizontalGroup(
            painelPintador1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 345, Short.MAX_VALUE)
        );
        painelPintador1Layout.setVerticalGroup(
            painelPintador1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 205, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addComponent(painelPintador1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addComponent(painelPintador1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jScrollPane2.setViewportView(jPanel3);

        jSplitPane2.setRightComponent(jScrollPane2);

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jSplitPane2)
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jSplitPane2)
        );

        jSplitPane1.setLeftComponent(jPanel2);

        jSplitPane3.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);
        jSplitPane3.setResizeWeight(1.0);
        jSplitPane3.setTopComponent(inspector1);

        javax.swing.GroupLayout inspectorDicas1Layout = new javax.swing.GroupLayout(inspectorDicas1);
        inspectorDicas1.setLayout(inspectorDicas1Layout);
        inspectorDicas1Layout.setHorizontalGroup(
            inspectorDicas1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 207, Short.MAX_VALUE)
        );
        inspectorDicas1Layout.setVerticalGroup(
            inspectorDicas1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 100, Short.MAX_VALUE)
        );

        jSplitPane3.setRightComponent(inspectorDicas1);

        jSplitPane1.setRightComponent(jSplitPane3);

        jPanel1.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        btnPronto.setText(bundle.getString("DrawerEditor.Pronto")); // NOI18N
        btnPronto.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnProntoActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnPronto)
                .addGap(2, 2, 2))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addGap(0, 0, 0)
                .addComponent(btnPronto))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jToolBar1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jSplitPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 692, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jToolBar1, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, 0)
                .addComponent(jSplitPane1)
                .addGap(0, 0, 0)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnProntoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnProntoActionPerformed
        this.setVisible(false);
    }//GEN-LAST:event_btnProntoActionPerformed

    private void btnNovoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNovoActionPerformed
        int idx = Lista.getSelectedIndex();
        Item.AddItem();
        PopuleLista();
        Lista.setSelectedIndex(idx);
        painelPintador1.repaint();
        Item.DoMuda();
        Item.InvalidateArea();
    }//GEN-LAST:event_btnNovoActionPerformed

    private void btnExcluirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnExcluirActionPerformed
        int idx = Lista.getSelectedIndex();
        Item.getItens().remove(Selecionado);
        PopuleLista();
        if (idx < Lista.getModel().getSize()) {
            Lista.setSelectedIndex(idx);
        } else if (Lista.getModel().getSize() > 0) {
            Lista.setSelectedIndex(Lista.getModel().getSize() - 1);
        } else {
            Lista.setSelectedIndex(-1);
        }
        Item.InvalidateArea();
        Item.DoMuda();
    }//GEN-LAST:event_btnExcluirActionPerformed

    private void btnSubirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSubirActionPerformed
        int idx = Lista.getSelectedIndex();
        if (idx > 0) {
            int nv = idx - 1;
            Item.getItens().remove(Selecionado);
            Item.getItens().add(nv, Selecionado);
            PopuleLista();
            Lista.setSelectedIndex(nv);
            Item.InvalidateArea();
            Item.DoMuda();
        }
    }//GEN-LAST:event_btnSubirActionPerformed

    private void btnDescerActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDescerActionPerformed
        int idx = Lista.getSelectedIndex();
        if (idx < Lista.getModel().getSize()) {
            int nv = idx + 1;
            Item.getItens().remove(Selecionado);
            Item.getItens().add(nv, Selecionado);
            PopuleLista();
            Lista.setSelectedIndex(nv);
            Item.InvalidateArea();
            Item.DoMuda();
        }
    }//GEN-LAST:event_btnDescerActionPerformed

    private void btnDupliqueActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDupliqueActionPerformed
        int idx = Lista.getSelectedIndex();
        Item.AddItem().Clone(Selecionado);
        PopuleLista();
        Lista.setSelectedIndex(idx);
        painelPintador1.repaint();
        Item.DoMuda();
        Item.InvalidateArea();
    }//GEN-LAST:event_btnDupliqueActionPerformed

    @Override
    public boolean AceitaEdicao(InspectorProperty propriedade, String valor) {
        try {
            switch (propriedade.property) {
//#Removido o "Medida".
//# Talvez, no futuro ele volte. Atualmente considerado inadequado e trabalhoso. Talvez possa usar a régua como base para o futuro desenho.
//# Código permanece em baseDrawerItem! //??: TO-DO: Remover códigos!
//#                case "setLeft":
//#                    Selecionado.setLeft(Integer.valueOf(valor));
//#                    break;
//#                case "setTop":
//#                    Selecionado.setTop(Integer.valueOf(valor));
//#                    break;
//#                case "setWidth":
//#                    Selecionado.setWidth(Integer.valueOf(valor));
//#                    break;
//#                case "setHeight":
//#                    Selecionado.setHeight(Integer.valueOf(valor));
//#                    break;
                case "SetTipo":
                    Selecionado.SetTipo(Integer.valueOf(valor));
                    DefaultListModel dlm = (DefaultListModel) Lista.getModel();
                    dlm.set(Lista.getSelectedIndex(),
                            Integer.toString(Lista.getSelectedIndex()) + " "
                            + Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem." + Selecionado.getTipo().name().toLowerCase()));
                    break;
                case "setPath":
                    Selecionado.setPath(valor);
                    break;
                case "setFill":
                    Selecionado.setFill(Boolean.valueOf(valor));
                    break;
//#                case "setInvertido":
//#                    Selecionado.setInvertido(Boolean.valueOf(valor));
//#                    break;
                case "setRecivePaint":
                    Selecionado.setRecivePaint(Boolean.valueOf(valor));
                    break;
                case "setCor":
                    Selecionado.setCor(util.Utilidades.StringToColor(valor));
                    break;
                case "setRetangulo":
                    Selecionado.setRetangulo(valor);
                    break;
                case "setElipse":
                    Selecionado.setElipse(valor);
                    break;
                case "setCurva":
                    Selecionado.setCurva(valor);
                    break;
                case "setArco":
                    Selecionado.setArco(valor);
                    break;
                case "setPosiImagem":
                    Selecionado.setPosiImagem(valor);
                    break;
                case "setVertical":
                    Selecionado.setVertical(Boolean.valueOf(valor));
                    break;
                case "setGradiente":
                    Selecionado.setGradiente(Boolean.valueOf(valor));
                    break;
                case "setGradienteStartColor":
                    Selecionado.setGradienteStartColor(util.Utilidades.StringToColor(valor));
                    break;
                case "setGradienteEndColor":
                    Selecionado.setGradienteEndColor(util.Utilidades.StringToColor(valor));
                    break;
                case "setDirecaogradiente":
                    Selecionado.setDirecaogradiente(Integer.valueOf(valor));
                    break;

            }
        } catch (Exception e) {
            BrLogger.Logger("AceitaEdicao", e.getMessage());
            PerformInspectorFor();
            Item.InvalidateArea();
            return false;
        }
        PerformInspectorFor();
        Item.DoMuda();
        Item.InvalidateArea();
        return true;
    }

    @Override
    public boolean ProcesseCmdFromInspector(String property) {

        FormaElementar.nomeComandos cmd;
        try {
            cmd = FormaElementar.nomeComandos.valueOf(property);
        } catch (Exception e) {
            return false;
        }

        switch (cmd) {
            case cmdLoadImg:
                //String titulo = fromConfiguracao.getValor(property);
                String res = util.Dialogos.ShowDlgFileImg(this.getRootPane());//, titulo); 
                if (res == null) {
                    return true; //não é erro, foi cancelado pelo usuário.
                }
                if (Selecionado.LoadImageFromFile(res)) {
                    PerformInspectorFor();
                    Item.DoMuda();
                    Item.InvalidateArea();
                    return true;
                }
                PerformInspectorFor();
                //return false;
                break;
            case cmdDoAnyThing:
                Selecionado.DoAnyThing(inspector1.getSelecionado().getPropriedade().Tag);
                PerformInspectorFor();
                Item.DoMuda();
                Item.InvalidateArea();
                return true;
        }
        return false;
    }

    private Editor omaster = null;
    private iBaseDrawer Item = null;

    public void Inicie(FormaElementar selecionado) {
        omaster = selecionado.getMaster().getEditor();
        omaster.InicieNovoInspector(inspector1, this);
        Item = (iBaseDrawer) selecionado;
        PopuleLista();
        PerformInspectorFor();

        Lista.addListSelectionListener((ListSelectionEvent e) -> {
            if (e.getValueIsAdjusting()) {
                return;
            }
            PerformInspectorFor();
        });
        painelPintador1.setSize(new Dimension(selecionado.getWidth(), selecionado.getHeight()));
        painelPintador1.setPreferredSize(painelPintador1.getSize());
    }
    baseDrawerItem Selecionado = null;

    public void PerformInspectorFor() {
        Selecionado = null;
        if (omaster == null || Item == null) {
            RefreshMenus();
            return;
        }
        omaster.setTextoDica(null, "");

        ArrayList<InspectorProperty> res = new ArrayList<>();
        res.add(InspectorProperty.PropertyFactorySeparador("basedraweritem.titulo"));
        painelPintador1.getPintaveis().clear();
        if (Lista.getSelectedIndex() > -1) {
            Selecionado = Item.getItens().get(Lista.getSelectedIndex());
            Popule(res);
            ////pintando distante por conta l e t do modelo!
            painelPintador1.getPintaveis().add(Selecionado);
        }
        painelPintador1.repaint();
        inspector1.Carrege(res);
        RefreshMenus();
    }

    private void Popule(ArrayList<InspectorProperty> res) {
        if (Selecionado == null) {
            return;
        }
        //#Removido o Medida, talvez um dia eu o volte. Está feio e trabalhoso, talvez possa usar a régua como base para o futuro desenho.
        //#res.add(InspectorProperty.PropertyFactoryNumero("left", "setLeft", Selecionado.getLeft()));
        //#res.add(InspectorProperty.PropertyFactoryNumero("top", "setTop", Selecionado.getTop()));
        //#res.add(InspectorProperty.PropertyFactoryNumero("width", "setWidth", Selecionado.getWidth()));
        //#res.add(InspectorProperty.PropertyFactoryNumero("height", "setHeight", Selecionado.getHeight()));

        //tpRetangulo, tpElipse, tpCurva, tpArco, tpPath, tpImagem
        ArrayList<String> menu = new ArrayList<>();
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tpretangulo"));
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tpelipse"));
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tpcurva"));
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tparco"));
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tppath"));
        menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tpimagem"));
        //#menu.add(Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem.tpmedida"));

        res.add(InspectorProperty.PropertyFactoryMenu("basedraweritem.tipo", "SetTipo", Selecionado.getTipo().ordinal(), menu).
                AddCondicao(new String[]{"0"}, new String[]{"setRetangulo"}).
                AddCondicao(new String[]{"1"}, new String[]{"setElipse"}).
                AddCondicao(new String[]{"2"}, new String[]{"setCurva"}).
                AddCondicao(new String[]{"3"}, new String[]{"setArco"}).
                AddCondicao(new String[]{"4"}, new String[]{"setPath"}).
                AddCondicao(new String[]{"5"}, new String[]{FormaElementar.nomeComandos.cmdLoadImg.name(), FormaElementar.nomeComandos.cmdDoAnyThing.name(), "desenhador.imagem.size", "setPosiImagem"})
                //#.AddCondicao(new String[]{"6"}, new String[]{"setInvertido", "setWidth", "setHeight", "setTop", "setLeft", "setVertical"})
        );

        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.retangulo", "setRetangulo", Selecionado.getRetangulo()));
        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.elipse", "setElipse", Selecionado.getElipse()));
        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.curva", "setCurva", Selecionado.getCurva()));
        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.arco", "setArco", Selecionado.getArco()));
        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.path", "setPath", Selecionado.getPath()));
        res.add(InspectorProperty.PropertyFactoryTexto("basedraweritem.posiimg", "setPosiImagem", Selecionado.getPosiImagem()));
        
        res.add(InspectorProperty.PropertyFactoryCommand(FormaElementar.nomeComandos.cmdLoadImg.name()));
        Point p = Selecionado.GetImgSize();
        res.add(InspectorProperty.PropertyFactoryApenasLeituraTexto("desenhador.imagem.size", "(" + String.valueOf(p.x) + " ," + String.valueOf(p.y) + ")"));
        res.add(InspectorProperty.PropertyFactoryCommand(FormaElementar.nomeComandos.cmdDoAnyThing.name(), "desenhador.imagem.resize").setTag(1));

        //#res.add(InspectorProperty.PropertyFactorySN("basedraweritem.medida.vertical", "setVertical", Selecionado.isVertical()));

        res.add(InspectorProperty.PropertyFactorySN("basedraweritem.fill", "setFill", Selecionado.isFill()).PropertyForceDisable(Selecionado.getTipo() == baseDrawerItem.tipoDrawer.tpImagem || Selecionado.getTipo() == baseDrawerItem.tipoDrawer.tpMedida));
        //#res.add(InspectorProperty.PropertyFactorySN("basedraweritem.invertido", "setInvertido", Selecionado.isInvertido()));
        String[] g = new String[]{"setCor", "setGradiente", "setGradienteStartColor", "setGradienteEndColor", "setDirecaogradiente"
        };
        res.add(InspectorProperty.PropertyFactorySN("basedraweritem.recivepaint", "setRecivePaint", Selecionado.isRecivePaint()).
                AddCondicaoForFalse(g));
        res.add(InspectorProperty.PropertyFactoryCor("basedraweritem.cor", "setCor", Selecionado.getCor()));

        String[] grupo = new String[]{"setGradienteStartColor", "setGradienteEndColor", "setDirecaogradiente"
        };
        res.add(InspectorProperty.PropertyFactorySeparador("basedraweritem.gradiente"));
        res.add(InspectorProperty.PropertyFactorySN("basedraweritem.gradiente.is", "setGradiente", Selecionado.isGradiente()).AddCondicaoForFalse(new String[]{"setCor"}).AddCondicaoForTrue(grupo));
        res.add(InspectorProperty.PropertyFactoryCor("basedraweritem.gradiente.startcor", "setGradienteStartColor", Selecionado.getGradienteStartColor()));
        res.add(InspectorProperty.PropertyFactoryCor("basedraweritem.gradiente.endcor", "setGradienteEndColor", Selecionado.getGradienteEndColor()));
        res.add(InspectorProperty.PropertyFactoryMenu("basedraweritem.gradiente.direcao", "setDirecaogradiente", Selecionado.getDirecaogradiente(), Editor.fromConfiguracao.getLstDirecao(Controler.Comandos.cmdTexto)));
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JList Lista;
    private javax.swing.JButton btnDescer;
    private javax.swing.JButton btnDuplique;
    private javax.swing.JButton btnExcluir;
    private javax.swing.JButton btnNovo;
    private javax.swing.JButton btnPronto;
    private javax.swing.JButton btnSubir;
    private controlador.inspector.Inspector inspector1;
    private controlador.inspector.InspectorDicas inspectorDicas1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JToolBar.Separator jSeparator1;
    private javax.swing.JToolBar.Separator jSeparator2;
    private javax.swing.JToolBar.Separator jSeparator3;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JSplitPane jSplitPane3;
    private javax.swing.JToolBar jToolBar1;
    private controlador.apoios.PainelPintador painelPintador1;
    // End of variables declaration//GEN-END:variables

    private void PopuleLista() {
        DefaultListModel lst = new DefaultListModel();
        int t = 0;
        for (baseDrawerItem bi : Item.getItens()) {
            lst.addElement(Integer.toString(t++) + " " + Editor.fromConfiguracao.getValor("Inspector.lst.basedraweritem." + bi.getTipo().name().toLowerCase()));
        }
        Lista.setModel(lst);
    }

    private void RefreshMenus() {
        if (Selecionado == null) {
            btnDescer.setEnabled(false);
            btnSubir.setEnabled(false);
            btnExcluir.setEnabled(false);
            btnDuplique.setEnabled(false);
            return;
        }
        btnExcluir.setEnabled(true);
        btnDuplique.setEnabled(true);
        int utimo = Lista.getModel().getSize() - 1;
        int idx = Lista.getSelectedIndex();

        btnDescer.setEnabled(idx < utimo);
        btnSubir.setEnabled(idx > 0);
    }

}
